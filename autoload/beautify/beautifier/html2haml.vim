let s:source = {
      \ 'hooks' : {},
      \ 'option' : '',
      \ }
function! beautify#beautifier#html2haml#define() "{{{
  if !exists('s:html2haml')
    let s:html2haml = copy(s:source)
    let s:html2haml.name = 'html2haml'

    let s:erb2haml  = copy(s:source)
    let s:erb2haml.name = 'erb2haml'
    let s:erb2haml.option = '--erb'
  endif

  return [s:html2haml, s:erb2haml]
endfunction"}}}

let g:beautify#beautifier#html2haml#bin =
      \ get(g:, 'beautify#beautifier#html2haml#bin', 'html2haml')
let g:beautify#beautifier#html2haml#ruby19_attributes =
      \ get(g:, 'beautify#beautifier#html2haml#ruby19_attributes', 0)

function! s:system(commands) "{{{
  if g:beautify#beautifier#html2haml#ruby19_attributes
    if !exists('s:html2haml_is_latest')
      let s:html2haml_is_latest = system('html2haml --version') =~ '2.0.0'
    endif

    if s:html2haml_is_latest
      call add(a:commands, '--ruby19-attributes')
    endif
  endif

  return system(join(a:commands), ' ')
endfunction"}}}

function! s:source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()
  let option = self.option

  return s:system([g:beautify#beautifier#html2haml#bin, option, temp_file])
endfunction"}}}

function! s:source.available() "{{{
  if executable(g:beautify#beautifier#html2haml#bin)
    return 1
  else
    return 'gem install html2haml'
  endif
endfunction"}}}
