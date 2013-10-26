let g:beautify#beautifier#jq#bin = get(g:, 'beautify#beautifier#jq#bin', 'jq')
let s:source = {
      \ 'name' : 'jq',
      \ 'filetype' : 'json',
      \ 'disable_partial' : 1,
      \ 'hooks' : {},
      \ }
function! beautify#beautifier#jq#define() "{{{
  return s:source
endfunction"}}}

function! s:source.beautify(context) "{{{
  let temp_file = a:context.get_fully_tempfile()
  let bin = g:beautify#beautifier#jq#bin
  let command = 'cat ' . temp_file . ' | jq "."'
  return system(command)
endfunction"}}}

function! s:source.available() "{{{
  if executable(g:beautify#beautifier#jq#bin)
    return 1
  else
    return 0
    echomsg 'Please run "npm install -g jq"'
  endif
endfunction"}}}
