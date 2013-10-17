let g:beautify#beautifier#js2coffee#bin =
      \ get(g:, 'beautify#beautifier#js2coffee#bin', 'js2coffee')

if !executable(g:beautify#beautifier#js2coffee#bin)
  echomsg 'Please run "npm install -g js2coffee"'
endif

function! s:system(commands) "{{{
  return system(join(a:commands), ' ')
endfunction"}}}

let s:source = {
      \ 'name' : 'js2coffee',
      \ 'hooks' : {},
      \ }
function! s:source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()

  return s:system(['cat', temp_file, '|', g:beautify#beautifier#js2coffee#bin])
endfunction"}}}

function! beautify#beautifier#js2coffee#define() "{{{
  return executable(g:beautify#beautifier#js2coffee#bin) ? s:source : {}
endfunction"}}}
