function! beautify#beautifier#get_sources(...) "{{{
  if !exists('s:sources')
    call beautify#beautifier#define_sources()
  endif

  if len(a:000) == 0
    return copy(s:sources)
  else
    let regexp_for_filtering = '^\(' . join(a:000, '\|') . '\)$'
    return filter(copy(s:sources), 'v:val.name =~ regexp_for_filtering')
  endif
endfunction"}}}

function! beautify#beautifier#get_sources_by_filetype(filetype) "{{{
  if empty(a:filetype)
    throw 'Filetype is empty!'
  endif

  let sources = beautify#beautifier#get_sources()
  return filter(sources, 'v:val.filetype == a:filetype')
endfunction"}}}

function! s:fill_default_value(source) "{{{
  let source = a:source
  let source.filetype = get(source, 'filetype', '')
  let source.priority = get(source, 'priority', 100)
  let source.disable_partial = get(source, 'disable_partial', 0)

  return source
endfunction"}}}

function! beautify#beautifier#define_sources() "{{{
  if exists('s:defined_sources')
    return 
  endif
  let s:defined_sources = 1

  let beautifier = split(globpath(&runtimepath, 'autoload/beautify/beautifier/*.vim'), '\n')
  let source_file_names = map(beautifier, 'fnamemodify(v:val, ":t:r")')
  let s:sources = []

  for source_name in source_file_names
    let source_list = beautify#utils#to_array(beautify#beautifier#{source_name}#define())

    for beautifier_source in source_list
      if !empty(beautifier_source)
        call add(s:sources, s:fill_default_value(beautifier_source))
      endif
    endfor
  endfor
endfunction"}}}

function! beautify#beautifier#update_sources() "{{{
  if exists('s:defined_sources')
    unlet s:defined_sources
  endif
  call beautify#beautifier#define_sources()
endfunction"}}}

function! beautify#beautifier#initialize() "{{{
  if !exists('s:loaded_beautifier')
    call beautify#beautifier#define_sources()
    let s:loaded_beautifier = 1
  endif
endfunction"}}}

" Context
let s:default_context = {}

function! beautify#beautifier#get_context() "{{{
  let context = beautify#use_current_file()

  if exists('b:beautify')
    return b:beautify.context
  elseif context
    return context
  endif
endfunction"}}}

function! s:get_tempfile(start, end) "{{{
  let content = getline(a:start, a:end)
  let temp_file = tempname()
  call writefile(content, temp_file)

  return temp_file
endfunction"}}}

function! s:default_context.get_tempfile() "{{{
  return self.is_range ? self.get_partial_tempfile() : self.get_fully_tempfile()
endfunction"}}}

function! s:default_context.get_fully_tempfile() "{{{
  return s:get_tempfile(0, '$')
endfunction"}}}

function! s:default_context.get_partial_tempfile() "{{{
  return s:get_tempfile(self.startline, self.endline)
endfunction"}}}

function! s:build_context(options) "{{{
  let context = copy(s:default_context)
  let context.file_name = expand('%:p')
  call extend(context, a:options)

  return context
endfunction"}}}

function! s:write_result_to_tempfile(output) "{{{
  if type(a:output) == type('')
    let parsed = split(a:output, '\n')
  elseif type(result) == type([])
    let parsed = a:output
  endif

  let output_file = tempname()
  call writefile(parsed, output_file)

  return output_file
endfunction"}}}

function! beautify#beautifier#run(name, ...) "{{{
  let options = len(a:000) == 0 ? {} : a:1

  call beautify#beautifier#initialize()
  let source_list = beautify#beautifier#get_sources(a:name)
  let context = s:build_context(options)

  if empty(source_list)
    throw '['. a:name .'] Source is not exists!'
    return
  endif

  " FIXME 最終的には全ての配列を精査する
  let source = source_list[0]
  let context.source = source
  if source.disable_partial == 1
    let context.is_range = 0
  endif

  let hooks = get(source, 'hooks', {})

  if has_key(hooks, 'on_init')
    call hooks.on_init(context)
  endif

  let result = source.beautify(context)

  if has_key(hooks, 'finalize')
    call hooks.on_init(context)
  endif

  let output_file = s:write_result_to_tempfile(result)
  return beautify#outputter#dispatch(context, output_file)
endfunction"}}}
