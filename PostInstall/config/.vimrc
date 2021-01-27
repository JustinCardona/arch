set number
syntax on
map <F7> :w <CR> :!python % <CR>
map <F8> :w <CR> :!gcc % -o %< && ./%< <CR>
