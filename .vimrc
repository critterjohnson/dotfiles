set number

if has("autocmd")

  augroup vimrcEx
    au!
    autocmd FileType text setlocal textwidth=78
  augroup END

else
  set autoindent

endif

if has('syntax') && has('eval')
  packadd! matchit
endif

