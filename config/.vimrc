set number
set mouse=a
syntax on
filetype plugin on
filetype indent on
map <F5> :w <CR> :!python % <CR>
map <F6> :w <CR> :!gcc % -o %< && ./%< <CR>
