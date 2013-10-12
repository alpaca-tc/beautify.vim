" Initialize variables
" TODO Sourceの方に移動させる

let g:beautify#beautifier#npm_beautifier#bin =
      \ get(g:, 'beautify#beautifier#npm_beautifier#bin',
      \ {
      \   'javascript' : 'js-beautify',
      \   'css'        : 'css-beautify',
      \   'html'       : 'html-beautify'
      \ })

if !executable(g:beautify#beautifier#npm_beautifier#bin.javascript)
  echomsg 'Please run "npm install -g js-beautify"'
endif

let s:default_source = {
      \ 'hooks' : {},
      \ }
function! s:default_source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()
  let commands = beautify#utils#to_array(self.bin)

  call extend(commands, ['--indent-size', &tabstop])
  call extend(commands, ['--indent-level', 0])
  call extend(commands, [temp_file])
  let command = join(commands, ' ')

  return system(command)
endfunction"}}}

let s:js_source = copy(s:default_source)
let s:js_source.bin = g:beautify#beautifier#npm_beautifier#bin['javascript']
let s:js_source.filetype = 'javascript'
let s:js_source.name = 'js-beautify'

let s:css_source = copy(s:default_source)
let s:css_source.bin = g:beautify#beautifier#npm_beautifier#bin['css']
let s:css_source.filetype = 'css'
let s:css_source.name = 'css-beautify'

let s:html_source = copy(s:default_source)
let s:html_source.bin = g:beautify#beautifier#npm_beautifier#bin['html']
let s:html_source.filetype = 'html'
let s:html_source.name = 'html-beautify'

function! beautify#beautifier#npm_beautifier#define() "{{{
  return [s:js_source, s:css_source, s:html_source]
endfunction"}}}
