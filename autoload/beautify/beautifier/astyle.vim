let g:beautify#beautifier#astyle#bin = 'astyle'

let s:source = {
      \ 'hooks' : {},
      \ 'option' : '--suffix=none --formatted',
      \ }

function! beautify#beautifier#astyle#define() " {{{
  if !exists('s:c')
    let s:c = copy(s:source)
    let s:c.name = 'c'
    let s:c.filetype = 'c'
    let s:c.option .= ' --mode=c --max-code-length=80 --indent=tab'

    let s:cpp = copy(s:source)
    let s:cpp.name = 'cpp'
    let s:cpp.filetype = 'cpp'
    let s:cpp.option .= ' --mode=c --max-code-length=80 --indent=tab'

    let s:java = copy(s:source)
    let s:java.name = 'java'
    let s:java.filetype = 'java'
    let s:java.option .= ' --mode=java'

    let s:cs = copy(s:source)
    let s:cs.name = 'cs'
    let s:cs.filetype = 'cs'
    let s:cs.option .= ' --mode=cs'
  endif

  return [s:c, s:cpp, s:java, s:cs]
endfunction"}}}

function! s:system(commands) "{{{
  let result = system(join(a:commands), ' ')
  let file = matchstr(result, '[^ ]\+$')

  return system('cat ' . file)
endfunction"}}}

function! s:source.beautify(context) "{{{
  let temp_file = a:context.get_tempfile()
  let g:huga = temp_file
  let option = self.option

  return s:system([g:beautify#beautifier#astyle#bin, option, temp_file])
endfunction"}}}

function! s:source.available() "{{{
  if executable(g:beautify#beautifier#astyle#bin)
    return 1
  else
    return '{brew, yum, apt-get} install astyle'
  endif
endfunction"}}}
