let g:beautify#beautifier#sass_convert#bin =
      \ get(g:, 'beautify#beautifier#sass_convert#bin', 'sass-convert')

if !executable(g:beautify#beautifier#sass_convert#bin)
  echomsg 'Please run "gem install sass"'
endif

function! beautify#beautifier#sass_converter#define() "{{{
  return executable(g:beautify#beautifier#sass_convert#bin) ? s:sources : {}
endfunction"}}}

function! s:parse_options(options) "{{{
  let options = []
  for key in ['--indent', '--from', '--to', '--no-cache']
    if has_key(a:options, key)
      call add(options, join([key, a:options[key]], ' '))
    endif
  endfor

  return options
endfunction"}}}

function! s:system(file_path, options) "{{{
  let commands = [g:beautify#beautifier#sass_convert#bin]
  call extend(commands, s:parse_options(a:options))
  call add(commands, a:file_path)

  return system(join(commands, ' '))
endfunction"}}}

" Define sources"{{{
let s:source = {
      \ 'name' : '',
      \ 'hooks' : {},
      \ }
function! s:source.beautify(context) "{{{
  let options = copy(self.options)
  return s:system(a:context.get_tempfile(), options)
endfunction"}}}

let s:definitions = {
      \ 'css2sass' : {
      \   '--from' : 'css',
      \   '--to' : 'sass',
      \ },
      \ 'css2scss' : {
      \   '--from' : 'css',
      \   '--to' : 'scss',
      \ },
      \ 'scss2sass' : {
      \   '--from' : 'scss',
      \   '--to' : 'sass',
      \ },
      \ 'sass2scss' : {
      \   '--from' : 'sass',
      \   '--to' : 'scss',
      \ },
      \ }
let s:sources = []
let g:huga = s:definitions
for name in keys(s:definitions)
  let options = s:definitions[name]

  let source = copy(s:source)
  let source.name = name
  let source.options = options
  call add(s:sources, source)
endfor
unlet source
unlet name
unlet options
"}}}
