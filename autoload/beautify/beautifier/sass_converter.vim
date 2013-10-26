let g:beautify#beautifier#sass_convert#bin =
      \ get(g:, 'beautify#beautifier#sass_convert#bin', 'sass-convert')

let s:source = {
      \ 'name' : '',
      \ 'hooks' : {},
      \ }

function! beautify#beautifier#sass_converter#define() "{{{
  if !exists('s:sources')
    let s:sources = []
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

    for name in keys(s:definitions)
      let options = s:definitions[name]

      let source = copy(s:source)
      let source.name = name
      let source.options = options
      call add(s:sources, source)
    endfor
  endif

  return s:sources
endfunction"}}}

function! s:system(file_path, options) "{{{
  let commands = [g:beautify#beautifier#sass_convert#bin]
  call extend(commands, s:parse_options(a:options))
  call add(commands, a:file_path)

  return system(join(commands, ' '))
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

function! s:source.beautify(context) "{{{
  let options = copy(self.options)
  return s:system(a:context.get_tempfile(), options)
endfunction"}}}

function! s:source.available() "{{{
  if executable(g:beautify#beautifier#sass_convert#bin)
    return 1
  else
    echomsg 'Please run "gem install sass"'
    return 0
  endif
endfunction"}}}
