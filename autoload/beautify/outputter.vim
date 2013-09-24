function! beautify#outputter#dispatch(context, output_file) "{{{
  if !filereadable(a:output_file)
    throw "Error occurred: Can't read output_file"
  endif

  let context = a:context
  let source = context.source

  if has_key(source, 'outputter')
    if type(source.outputter) == type(function('tr'))
      return source.outputter(context, a:output_file)
    elseif type(source.outputter) == type('')
      let outputter_name = source.outputter
    else
      echomsg string('Error occurred: Invalid outputter is selected.')
      return 0
    endif
  endif

  if !exists('outputter_name')
    let outputter_name =  g:beautify#default_outputter
  endif

  let context.outputter_name = outputter_name

  if exists('*beautify#outputter#' . outputter_name)
    " When function is exists
    call beautify#outputter#{outputter_name}(context, a:output_file)
  else
    call beautify#outputter#vim_command(context, a:output_file)
  endif
endfunction"}}}

function! beautify#outputter#vim_command(context, output_file) "{{{
  let output_file = a:output_file

  silent! execute a:command_name
  silent! 0read `=output_file`
endfunction"}}}

function! beautify#outputter#current_buffer(context, output_file) "{{{
  let output_file = a:output_file

  if a:context.is_range
    let delete_command = a:context.startline . ',' . a:context.endline . 'delete'
    silent execute delete_command
    let startline = a:context.startline - 1
    silent! execute startline . 'read `=output_file`'
  else
    silent %delete
    silent! 0read `=output_file`
  endif
endfunction"}}}
