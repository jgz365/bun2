" vim

syntax on
set nocompatible
set nu
set noswapfile
set ruler

set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set smartindent

set hlsearch
set incsearch
set ignorecase
set smartcase
set wrap
set list
set listchars=tab:→\ ,trail:·,extends:>,precedes:<

set nobackup

set showmatch
set wildmenu
set lazyredraw
set scrolloff=3

nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

" bash
autocmd BufWritePost *.sh :!chmod +x %
autocmd FileType sh nnoremap <buffer> <C-j> :!./%<CR>

" c stuff
autocmd Filetype c setlocal shiftwidth=2 tabstop=2

autocmd Filetype c nnoremap <buffer> <leader>c :s/^/\/\/ /<CR>
autocmd Filetype c nnoremap <buffer> <leader>u :s/^\/\/ //<CR>

let mapleader = ","

