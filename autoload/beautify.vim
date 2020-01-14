function! beautify#dispatch_beautify(...) range "{{{
  if len(a:000) == 0 && empty(&filetype)
    echomsg 'Error occurred: Source name is empty!'
    return 0
  endif

  let parsed_options = s:parse_options(a:000)

  call beautify#beautifier#run(parsed_options.source_name, parsed_options)
endfunction"}}}

function! s:filter_sources(source_name) "{{{
  let sources = beautify#beautifier#get_sources(a:source_name)
  let filetype = get(split(&filetype, '\.'), 0, '')

  if !empty(sources)
    return sources
  elseif !empty(filetype)
    let sources = beautify#beautifier#get_sources_by_filetype(filetype)
    return sources
  else
    throw '[Beautify] Invalid Arguments!'
  endif
endfunction"}}}

function! s:sort_sources(t1, t2) "{{{
  return a:t1.priority < a:t2.priority
endfunction"}}}

function! s:parse_options(args) "{{{
  let options = {
        \ 'count' : a:args[0],
        \ 'startline' : a:args[1],
        \ 'endline' : a:args[2],
        \ 'is_range' : (a:args[0] != -1)
        \ }

  let all_args = split(get(a:args, 3, ''), '\s\+')
  let source_name = get(all_args, 0, '')
  let sources = s:filter_sources(source_name)
  let options.args = all_args[1:]

  if empty(sources)
    echomsg 'Not found source of beautifier'
    return 0
  endif

  call sort(sources, 's:sort_sources')
  let options.source_name = sources[0].name

  return options
endfunction"}}}

function! beautify#complete_options(arg_lead, cmd_line, cursor_pos) "{{{
  let sources = beautify#beautifier#get_sources()
  let result = []
  call filter(sources, 'v:val.name =~ a:arg_lead')

  for source in sources
    call add(result, source.name)
  endfor

  return result
endfunction"}}}
