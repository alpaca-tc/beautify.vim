let g:beautify#beautifier#jq#bin = get(g:, 'beautify#beautifier#jq#bin', 'jq')

if !executable(g:beautify#beautifier#jq#bin)
  echomsg 'Please run "npm install -g jq"'
endif

let s:source = {
      \ 'name' : 'jq',
      \ 'filetype' : 'json',
      \ 'disable_partial' : 1,
      \ 'hooks' : {},
      \ }

function! s:source.beautify(context) "{{{
  let temp_file = a:context.get_fully_tempfile()
  let bin = g:beautify#beautifier#jq#bin
  let command = 'cat ' . temp_file . ' | jq "."'
  return system(command)
endfunction"}}}

function! beautify#beautifier#jq#define()
  return executable('jq') ? s:source : []
endfunction
