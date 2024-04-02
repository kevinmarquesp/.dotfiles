let mapleader="\<space>"

"" OVERWRITING DEFAULT KEYMAPS:
"" ----------------------------------------------------------------------------

inoremap <c-l> <esc>
vnoremap <c-l> <esc>
snoremap <c-l> <esc>

nnoremap j gj
nnoremap k gk
nnoremap Y yg$
nnoremap J mzJ"z
nnoremap n nzzzv
nnoremap N Nzzzv

" TODO :- make it only available on plain vim
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


"" WINDOWS TABS AND BUFFERS:
"" ----------------------------------------------------------------------------

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


"" FINDING FILES:
"" ----------------------------------------------------------------------------

nnoremap <c-p> :find ./**/*
nnoremap <leader>n :Ex<cr>
autocmd FileType netrw nnoremap <buffer> <leader>n <c-6>


"" CHANGE SETTINGS ON THE FLY:
"" ----------------------------------------------------------------------------

nnoremap <leader><c-w> :setl wrap!<cr>
nnoremap <leader>: :set number! relativenumber!<cr>


"" EDITING AND FORMATING:
"" ----------------------------------------------------------------------------

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

vnoremap <f2> :%s///<left><left>
