function! beautify#debug#check_available()
  let sources = beautify#beautifier#get_sources()
  for source in sources
    call source.available()
  endfor
endfunction
