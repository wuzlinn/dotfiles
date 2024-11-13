syntax on

set ruler
set number
set tabstop=8
set softtabstop=8
set shiftwidth=8
set expandtab

set hlsearch
set backspace=indent,eol,start
set clipboard^=unnamed

autocmd FileType make setlocal noexpandtab tabstop=8 softtabstop=8 shiftwidth=8
autocmd FileType json setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType yml, yaml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2