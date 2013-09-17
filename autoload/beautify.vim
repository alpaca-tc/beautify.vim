" Utils
function! s:copy_current_buffer_to_tempfile() "{{{
  let content = getline(0, line('$'))
  let temp_file = tempname()
  call writefile(content, temp_file)

  return temp_file
endfunction"}}}

function! s:run(commands) "{{{
  let commands = a:commands " => ['js-beautify'] or ['html-beautify'] or ['css-beautify']

  let temp_file = s:copy_current_buffer_to_tempfile()

  call extend(commands, ['--indent-size', &tabstop])
  call extend(commands, ['--indent-char', '" "'])
  call extend(commands, ['--indent-level', 0])
  call extend(commands, [temp_file])
  let command = join(commands, ' ')

  let result = system(command)

  let output_file = tempname()
  call writefile(split(result, '\n'), output_file)

  call beautify#outputter#dispatch(output_file)
endfunction"}}}

" Commands
function! beautify#dispatch_beautify() "{{{
  if empty(&filetype)
    echomsg 'Error occurred: File type is empty!'
    return 0
  endif

  let filetype = split(&filetype, '\.')[0]

  if exists('*beautify#' . filetype) && filetype =~ 'css\|html\|javascript' 
    call beautify#{filetype}()
  else
    echomsg 'Sorry, Beautify supported only javascript, html and css.'
  endif
endfunction"}}}

function! beautify#javascript() "{{{
  let commands = [g:beautify#bin['javascript']]
  call s:run(commands)
endfunction"}}}

function! beautify#css() "{{{
  let commands = [g:beautify#bin['css']]
  call s:run(commands)
endfunction"}}}

function! beautify#html() "{{{
  let commands = [g:beautify#bin['html']]
  call s:run(commands)
endfunction"}}}
