function! beautify#dispatch_beautify(...) range "{{{
  if len(a:000) == 0 && empty(&filetype)
    echomsg 'Error occurred: Source name is empty!'
    return 0
  endif

  let parsed_options = s:parse_options(a:000)

  call beautify#beautifier#run(parsed_options.source_name, parsed_options)
endfunction"}}}

function! s:parse_options(args) "{{{
  let options = {
        \ 'count' : a:args[0],
        \ 'startline' : a:args[1],
        \ 'endline' : a:args[2],
        \ }
  let options.is_range = (options.startline =~ 1 && options.endline =~ 1) ? 1 : 0

  let fargs = a:args[3:]
  let regexp_for_filtering = '\(' . join(fargs, '\|') . '\)'

  let sources = beautify#beautifier#get_sources()
  call filter(sources, 'v:val.name =~ regexp_for_filtering')

  if empty(sources)
    throw '[Beautify] Invalid Arguments!'
  endif

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
