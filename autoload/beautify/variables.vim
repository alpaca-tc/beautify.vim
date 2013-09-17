function! beautify#variables#initialize()
  let g:beautify#bin = get(g:, 'beautify#bin', {
        \ 'javascript' : 'js-beautify',
        \ 'css'        : 'css-beautify',
        \ 'html'       : 'html-beautify'})
  let g:beautify#outputter = get(g:, 'beautify#outputter', 'current_buffer')

  if !executable(g:beautify#bin.javascript)
    echomsg 'Please run "npm install -g js-beautify"'
    return 0
  endif
endfunction
