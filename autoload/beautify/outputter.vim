function! beautify#outputter#dispatch(output_file, ...) "{{{
  let outputter_name = len(a:000) == 0 ? g:beautify#outputter : a:1

  if exists('*beautify#outputter#' . outputter_name)
    " When function is exists
    call beautify#outputter#{outputter_name}(a:output_file)
  else
    call beautify#outputter#vim_command(outputter_name, a:output_file)
  endif
endfunction"}}}

function! beautify#outputter#vim_command(command_name, output_file) "{{{
  let output_file = a:output_file

  if filereadable(output_file)
    silent! execute a:command_name
    silent! 0read `=output_file`
  else
    throw "Error occurred: Can't read file"
  endif
endfunction"}}}

function! beautify#outputter#current_buffer(output_file) "{{{
  let output_file = a:output_file

  silent %delete

  if filereadable(output_file)
    silent! 0read `=output_file`
  else
    throw "Error occurred: Can't read file"
  endif
endfunction"}}}
