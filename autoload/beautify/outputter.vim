function! beautify#outputter#dispatch(output_file) "{{{
  if exists('*beautify#outputter#' . g:beautify#outputter)
    " When function is exists
    call beautify#outputter#{g:beautify#outputter}(a:output_file)
  else
    call beautify#outputter#vim_command(a:output_file)
  endif
endfunction"}}}

function! beautify#outputter#vim_command(output_file) "{{{
  let output_file = a:output_file
  silent execute g:beautify#outputter

  if filereadable(output_file)
    0read `=output_file`
  else
    throw "Error occurred: Can't read file"
  endif
endfunction"}}}

function! beautify#outputter#current_buffer(output_file) "{{{
  let output_file = a:output_file

  %delete

  if filereadable(output_file)
    0read `=output_file`
  else
    throw "Error occurred: Can't read file"
  endif
endfunction"}}}
