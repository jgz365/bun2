call plug#begin('~/.vim/plugged')

" Aesthetics
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

" File navigation
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" LSP + Others
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'vim-scripts/bash-support.vim'

" Formatting
Plug 'dense-analysis/ale'

" Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()

filetype plugin indent on
syntax on

set nocompatible
set number
set relativenumber
set cursorline
set encoding=utf-8
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes
set updatetime=300
set hidden
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir
set backspace=indent,eol,start
set ruler
set showcmd
set wildmenu
set wildmode=longest:full,full
set splitbelow
set splitright

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set colorcolumn=80

set incsearch
set hlsearch
set ignorecase
set smartcase

set termguicolors
set background=dark
colorscheme gruvbox

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = 1

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '--background-index']},
        \ 'whitelist': ['c', 'cpp'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap  gd (lsp-definition)
    nmap  gr (lsp-references)
    nmap  K  (lsp-hover)
    nmap  rn (lsp-rename)
    nmap  [g (lsp-previous-diagnostic)
    nmap  ]g (lsp-next-diagnostic)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap     pumvisible() ? "\" : "\"
inoremap   pumvisible() ? "\" : "\"
inoremap      pumvisible() ? asyncomplete#close_popup() : "\"
set completeopt=menuone,noinsert,noselect
let g:asyncomplete_auto_popup = 1

let g:ale_linters = { 'c': ['clangd', 'gcc'] }
let g:ale_fixers  = {
\   'c': ['clang-format'],
\   '*': ['remove_trailing_whitespace'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error   = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nnoremap n :NERDTreeToggle
let g:NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1

let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" CLang
nnoremap cc :!gcc % -o %:r && ./%:r
" CLang
nnoremap cd :!gcc -g % -o %:r
