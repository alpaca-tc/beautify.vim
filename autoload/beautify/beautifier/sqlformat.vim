let g:beautify#beautifier#sqlformat#bin =
      \ get(g:, 'beautify#beautifier#sqlformat#bin', 'sqlformat')

let s:source = {
      \ 'name' : 'sqlformat',
      \ 'filetype' : 'sql',
      \ 'hooks' : {},
      \ }

let s:default_options = ['-r -k upper']

function! beautify#beautifier#sqlformat#define() "{{{
  return s:source
endfunction "}}}

function! s:system(file_path, options) "{{{
  let commands = [g:beautify#beautifier#sqlformat#bin]
  call extend(commands, a:options)
  call add(commands, a:file_path)

  return system(join(commands, ' '))
endfunction"}}}

function! s:source.beautify(context) "{{{
  let options = get(g:, 'beautify#beautifier#sqlformat#default_options', s:default_options)

  if !empty(a:context.args)
    let options = a:context.args
  endif

  return s:system(a:context.get_tempfile(), options)
endfunction "}}}

function! s:source.available() "{{{
  if executable(g:beautify#beautifier#sqlformat#bin)
    return 1
  else
    return 'pip install sqlparse'
  endif
endfunction "}}}
