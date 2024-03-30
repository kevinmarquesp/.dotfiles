command! MakeTags !ctags -R --exclude=.git --exclude=node_modules
command! MakeVimrc !cat ~/.config/nvim/shared/*.vim | sed -e '/^ *$/d;/^".*/d' > ~/.vimrc
set noexpandtab smartindent breakindent linebreak
set shiftwidth=4 tabstop=4 formatoptions=1
set nowrap colorcolumn=8
au BufWinEnter *.html setl shiftwidth=2 tabstop=2
au BufWinEnter *.cpp setl shiftwidth=2 tabstop=2
au BufWinEnter *.ino setl shiftwidth=2 tabstop=2
au BufWinEnter *.c setl shiftwidth=2 tabstop=2
au BufWinEnter *.ex setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.exs setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.lua setl shiftwidth=3 tabstop=3 expandtab
let mapleader="\<space>"
inoremap <c-l> <esc>
vnoremap <c-l> <esc>
snoremap <c-l> <esc>
nnoremap j gj
nnoremap k gk
nnoremap Y yg$
nnoremap J mzJ"z
nnoremap n nzzzv
nnoremap N Nzzzv
if !has("nvim")
    inoremap / /<c-x><c-f><c-p>
    inoremap . .<c-n><c-p>
    inoremap ( (<c-n><c-p>
    inoremap [ [<c-n><c-p>
    inoremap { {<c-n><c-p>
    inoremap , ,<c-n><c-p>
    inoremap ) )<c-n><c-p>
    inoremap ] ]<c-n><c-p>
    inoremap } }<c-n><c-p>
endif
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa!<cr>
nnoremap <c-s> :w!<cr>
inoremap <c-s> <esc>:w!<cr>
vnoremap <c-s> :w!<cr>
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>
nnoremap <leader>bd :bdelete<cr>
nnoremap <leader>T :tabnew<cr>
nnoremap <leader><tab> :tabnext<cr>
nnoremap <leader><s-tab> :tabprevious<cr>
nnoremap <leader>i :vsplit<cr>
nnoremap <leader>s :split<cr>
nnoremap <leader>= <c-w>=
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
nnoremap <left> :vertical resize +1<cr>
nnoremap <down> :resize -1<cr>
nnoremap <up> :resize +1<cr>
nnoremap <right> :vertical resize -1<cr>
if has("nvim")
    nnoremap <leader>t :split<cr>:set nonu nornu<cr>:term fish<cr>a
else
    nnoremap <leader>t :term<cr>a
endif
nnoremap <c-p> :find ./**/*
nnoremap <leader>n :Ex<cr>
autocmd FileType netrw nnoremap <buffer> <leader>n <c-6>
nnoremap <leader><c-w> :setl wrap!<cr>
nnoremap <leader>: :set number! relativenumber!<cr>
inoremap <c-k> <cr><esc>O
nnoremap <leader>gg mzgg=G"z
nnoremap <leader><leader> @
nnoremap <f2> :%s/<c-r><c-w>//g<c-r><c-r><left><left><left>
xnoremap <leader>p "_dP
nnoremap <leader>1 :set shiftwidth=2 tabstop=2<cr>
nnoremap <leader>2 :set shiftwidth=4 tabstop=4<cr>
nnoremap <leader>3 :set shiftwidth=8 tabstop=8<cr>
nnoremap <leader>. A.<esc>
nnoremap <leader>, A,<esc>
nnoremap <leader>; A;<esc>
nnoremap <leader>: A:<esc>
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
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
set splitbelow splitright
au CursorHold * checktime
au BufWinEnter *.txt set ft=help
if !has("nvim")
    au BufWinEnter *.ino set ft=cpp
endif
set noswapfile nobackup
set undofile undodir=~/.vim/undo_dir
set number relativenumber
set nowrap cursorline
set wildmenu
set colorcolumn=80
syntax on
colorscheme pablo
set fcs=eob:\ 
set hlsearch incsearch
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
autocmd BufNewFile,BufRead *.edge set filetype=html
