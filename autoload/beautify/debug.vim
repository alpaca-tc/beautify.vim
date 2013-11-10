function! beautify#debug#check_available()
  let sources = beautify#beautifier#get_all_sources()
  let messages = []

  for source in sources
    let result = source.available()
    if type('') == type(result)
      call add(messages, result)
    endif

    unlet result
  endfor

  if empty(messages)
    echomsg 'All sources are available'
  else
    echohl Error | echomsg 'Please install those: ' . join(messages, "\n") | echohl None
  endif
endfunction
