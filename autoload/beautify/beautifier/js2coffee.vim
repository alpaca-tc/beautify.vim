let g:beautify#beautifier#js2coffee#bin =
      \ get(g:, 'beautify#beautifier#js2coffee#bin', 'js2coffee')
let s:source = {
      \ 'name' : 'js2coffee',
      \ 'hooks' : {},
      \ }
function! beautify#beautifier#js2coffee#define() "{{{
  return s:source
endfunction"}}}

function! s:system(commands) "{{{
  return system(join(a:commands), ' ')
endfunction"}}}

function! s:source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()

  return s:system(['cat', temp_file, '|', g:beautify#beautifier#js2coffee#bin])
endfunction"}}}

function! s:source.available() "{{{
  if executable(g:beautify#beautifier#js2coffee#bin)
    return 1
  else
    echomsg 'Please run "npm install -g js2coffee"'
    return 0
  endif
endfunction"}}}
