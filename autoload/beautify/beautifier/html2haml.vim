let g:beautify#beautifier#html2haml#bin =
      \ get(g:, 'beautify#beautifier#html2haml#bin', 'html2haml')
let g:beautify#beautifier#html2haml#ruby19_attributes =
      \ get(g:, 'beautify#beautifier#html2haml#ruby19_attributes', 0)

if !executable(g:beautify#beautifier#html2haml#bin)
  echomsg 'Please run "gem install html2haml"'
endif

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

let s:html2haml_source = {
      \ 'name' : 'html2haml',
      \ 'hooks' : {},
      \ }
function! s:html2haml_source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()

  return s:system([g:beautify#beautifier#html2haml#bin, temp_file])
endfunction"}}}

let s:erb2haml_source = {
      \ 'name' : 'erb2haml',
      \ 'hooks' : {},
      \ }
function! s:erb2haml_source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()
  return s:system([g:beautify#beautifier#html2haml#bin, '--erb', temp_file])
endfunction"}}}

function! beautify#beautifier#html2haml#define() "{{{
  let source = [s:html2haml_source, s:erb2haml_source]
  return executable(g:beautify#beautifier#html2haml#bin) ? source : {}
endfunction"}}}
