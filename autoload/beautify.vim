function! beautify#dispatch_beautify(...) range "{{{
  if len(a:000) == 0 && empty(&filetype)
    echomsg 'Error occurred: Source name is empty!'
    return 0
  endif

  " TODO Rangeの情報を付加する
  let parsed_options = s:parse_options(a:000)

  call beautify#beautifier#run(parsed_options.source_name, parsed_options)
endfunction"}}}

function! s:parse_options(args)
  " TODO SourceNameを抜き出すようにする
  return { 'source_name' : 'js-beautify' }
endfunction

function! beautify#complete_options(arg_lead, cmd_line, cursor_pos) "{{{
  " Sourcenameを補完するようにする
  return []
endfunction"}}}
