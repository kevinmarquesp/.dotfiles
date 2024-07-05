let mapleader="\<space>"

" Overwriting Default Keymaps:
"	Some keymaps of Vim doesn't work as expected or even exist, this first
"	section fix that for me.

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

" Panes And Buffer Related Binding:
"	In fact, this section is related to organized and position the information
"	of the buffers on the screen - resizing panes, creating windows, selecting,
"	saving and quiting from buffers, etc.

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
    nnoremap <leader>t :term<cr>
endif

" Finding And Exploring Files:
"	This part is quite fun, I can fuzzyfind files on the current directory like
"	Telescope or like the <c-p> key does in VS Code. Also I'm using Netrw to
"	explore the files by hand, which is cool to do without any plugins.

nnoremap <c-p> :find ./**/*

nnoremap <leader>n :Ex<cr> 
autocmd FileType netrw nnoremap <buffer> <leader>n <c-6>

" Update Visual Settings:
"	Allows me to update some linewrapping/identation settings on the fly.

nnoremap <leader><c-w> :setl wrap!<cr>
nnoremap <leader>: :set number! relativenumber!<cr>
nnoremap <leader>II :set expandtab!<cr>

nnoremap <leader>I1 :set shiftwidth=2 tabstop=2<cr>
nnoremap <leader>I2 :set shiftwidth=4 tabstop=4<cr>
nnoremap <leader>I3 :set shiftwidth=8 tabstop=8<cr>

nnoremap <leader>- :set colorcolumn=80<cr>
nnoremap <leader>+ :set colorcolumn=120<cr>

" Using The Number Keys To Create Bookmarks:
" Maybe it's just overkill, but I found more ease to press space + 1 than '
" and a number...

nnoremap <leader>0 '0
nnoremap <leader>1 '1
nnoremap <leader>2 '2
nnoremap <leader>3 '3
nnoremap <leader>4 '4
nnoremap <leader>5 '5
nnoremap <leader>6 '6
nnoremap <leader>7 '7
nnoremap <leader>8 '8
nnoremap <leader>9 '9

" Little Hacks And Formating Bindings Related:
"	This binding I created by myself for myself, gotta go fast. Maybe this
"	section wont be that useful for you, sorry.

inoremap <c-k> <cr><esc>O

nnoremap <leader>gg mzgg=G"z

nnoremap <leader><leader> @

nnoremap <f2> :%s/<c-r><c-w>//g<c-r><c-r><left><left><left>

xnoremap <leader>p "_dP

nnoremap <leader>. A.<esc>
nnoremap <leader>, A,<esc>
nnoremap <leader>; A;<esc>

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

vnoremap <f2> :%s///<left><left>
