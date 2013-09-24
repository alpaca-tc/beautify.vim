function! beautify#beautifier#get_sources(...) "{{{
  if !exists('s:sources')
    call beautify#beautifier#define_sources()
  endif

  if len(a:000) == 0
    return s:sources
  else
    let regexp_for_filtering = '^\(' . join(a:000, '\|') . '\)$'
    return filter(copy(s:sources), 'v:val.name =~ regexp_for_filtering')
  endif
endfunction"}}}

function! beautify#beautifier#define_sources() "{{{
  let beautifier = split(globpath(&runtimepath, 'autoload/beautify/beautifier/*.vim'), '\n')
  let source_file_names = map(beautifier, 'fnamemodify(v:val, ":t:r")')
  let s:sources = []

  for source_name in source_file_names
    let sources = beautify#beautifier#{source_name}#define()
    let source_list = beautify#utils#to_array(sources)

    for beautifier_source in source_list
      if !empty(beautifier_source)
        call add(s:sources, beautifier_source)
      endif
    endfor
  endfor
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

function! s:default_context.get_tempfile(start, end) "{{{
  " TODO contextのfile_nameに依存するようにする
  let content = getline(0, line('$'))
  let temp_file = tempname()
  call writefile(content, temp_file)

  return temp_file
endfunction"}}}

function! s:default_context.get_fully_tempfile() "{{{
  return self.get_tempfile(0, '$')
endfunction"}}}

function! s:default_context.get_partial_tempfile() "{{{
  let start_line = get(self, 'line1', 0)
  let end_line = get(self, 'line2', 0)
  return self.get_tempfile(start_line, end_line)
endfunction"}}}

function! s:build_context(options) "{{{
  let context = copy(s:default_context)
  let context.file_name = expand('%:p')
  call extend(context, a:options)

  return context
endfunction"}}}

function! s:send_result_to_outputter(source, output_file) "{{{
  if has_key(a:source, 'outputter')
    if type(a:source.outputter) == type(function('tr'))
      return a:source.outputter(a:output_file)
    elseif type(a:source.outputter) == type('')
      return beautify#outputter#dispatch(a:output_file, a:source.outputter)
    else
      echomsg string('Error occurred: Invalid outputter is selected.')
    endif
  else
    return beautify#outputter#dispatch(a:output_file)
  endif
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
    echomsg '['. a:name .'] Source is not exists!'
    return
  endif

  " FIXME 最終的には全ての配列を精査する
  let source = source_list[0]

  let hooks = get(source, 'hooks', {})

  if has_key(hooks, 'on_init')
    call hooks.on_init(context)
  endif

  let result = source.beautify(context)
  let output_file = s:write_result_to_tempfile(result)

  if has_key(hooks, 'finalize')
    call hooks.on_init(context)
  endif

  return s:send_result_to_outputter(source, output_file)
endfunction"}}}
