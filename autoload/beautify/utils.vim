function! beautify#utils#to_array(var)
  let var = a:var

  if type(var) == type([])
    return var
  else
    return [var]
  endif
endfunction
