"" QUICK FIX AND BEHAVIORS:
"" ----------------------------------------------------------------------------

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

set hidden confirm showmode
set autoread

if has("nvim")
    set laststatus=3
endif


"" WINDOWS BUFFERS TABS AND STATUS LINE SETTINGS:
"" ----------------------------------------------------------------------------

set splitbelow splitright
au CursorHold * checktime

" custom syntax hightlight for some files
au BufWinEnter *.txt set ft=help
if !has("nvim")
    au BufWinEnter *.ino set ft=cpp
endif

set noswapfile nobackup
set undofile undodir=~/.vim/undo_dir


"" EDITOR INTERFACE SETTINGS:
"" ----------------------------------------------------------------------------

set number relativenumber
set nowrap cursorline

set wildmenu
set colorcolumn=80

syntax on
colorscheme pablo
set fcs=eob:\ 

set hlsearch incsearch

" customizing NETRW interface
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

"" TODO: add description...
autocmd BufNewFile,BufRead *.edge set filetype=html
