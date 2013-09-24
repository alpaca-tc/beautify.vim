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
let s:js_source.bin = g:beautify#bin['javascript']
let s:js_source.name = 'js-beautify'

let s:css_source = copy(s:default_source)
let s:css_source.bin = g:beautify#bin['css']
let s:css_source.name = 'css-beautify'

let s:html_source = copy(s:default_source)
let s:html_source.bin = g:beautify#bin['html']
let s:html_source.name = 'html-beautify'

function! beautify#beautifier#npm_beautifier#define() "{{{
  if executable(g:beautify#bin['javascript']) && executable(g:beautify#bin['html']) && executable(g:beautify#bin['css'])
    return [s:js_source, s:css_source, s:html_source]
  else
    return []
  endif
endfunction"}}}