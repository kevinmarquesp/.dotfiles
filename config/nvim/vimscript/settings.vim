" Quick Fix Default Behaviors:
"	Fix the terminal colors, configure my clipboard share, path, mouse, etc. In
"	a nut shell, all the settings to distribute my config to other OS'es.

set clipboard^=unnamed,unnamedplus
set termguicolors encoding=UTF-8

if !has("nvim")
    set term=xterm-256color
endif

set path+=**
set path-=**/node_modules/**

set timeoutlen=200
set mouse=a
set nocompatible
set updatetime=50

set autoread

if has("nvim")
    set laststatus=3
endif

set noswapfile nobackup
set undofile undodir=~/.vim/undo_dir

" Windows And Buffer Related:
"	Setup some buffer and syntax hightlighting settings, some specif buffer
"	types I would like to use a specific syntax, for an example.

set hidden confirm showmode

set splitbelow splitright
au CursorHold * checktime

au BufWinEnter *.txt set ft=help
autocmd BufNewFile,BufRead *.edge set filetype=html

if !has("nvim")
    au BufWinEnter *.ino set ft=cpp
endif

" Look And Feel:
"	Fix some visual settings to improve readability, also, it fixes the Netrw
"	appearence.

set number relativenumber
set nowrap
set cursorline colorcolumn=80

set wildmenu

syntax on
colorscheme pablo
set fcs=eob:\ 

set hlsearch incsearch

let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
