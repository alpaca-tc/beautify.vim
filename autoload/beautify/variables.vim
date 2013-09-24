function! beautify#variables#initialize()
  " TODO Sourceの方に移動させる
  let g:beautify#bin = get(g:, 'beautify#bin', {
        \ 'javascript' : 'js-beautify',
        \ 'css'        : 'css-beautify',
        \ 'html'       : 'html-beautify'})

  let g:beautify#default_outputter = get(g:, 'beautify#default_outputter', 'current_buffer')

  if !executable(g:beautify#bin.javascript)
    echomsg 'Please run "npm install -g js-beautify"'
  endif
endfunction
