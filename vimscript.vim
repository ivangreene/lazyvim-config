" Map enter, shift+enter in normal mode to make line below or above cursor
nmap <silent> <expr> <CR> &buftype !=? 'quickfix' ? "o<Esc>" : "<CR>:cope " . g:qf_height . "<CR><M-k>:set cursorline<CR><M-j>"
nnoremap <silent> <expr> <C-K>ENTER &buftype !=? 'quickfix' ? "O<Esc>" : ":ccl<CR>:set nocursorline<CR>"

" always use vdiffsplit for fugitive dd
au FileType fugitive nmap <buffer> dd dv
