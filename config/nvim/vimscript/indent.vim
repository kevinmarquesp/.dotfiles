" Global Indentation Settings:
"	Apply to all files, these settings define the behavior that I like and
"	expect when I open a new buffer.

set autoindent noexpandtab smartindent breakindent linebreak
set shiftwidth=2 tabstop=2 formatoptions=1 expandtab

" General Settings Per File:
"	Here will be some helpers to make the writing easier, such as defining
"	a max line width before going to the next line.

autocmd BufNewFile,BufRead *.md set textwidth=80

" Indentation Size Per File:
"	These settings allows me to follow, just a little bit, the style guide of
"	the most languages out there without requiring an LSP formater plugin.

au BufWinEnter *.templ setl shiftwidth=2 tabstop=2 noexpandtab
au BufWinEnter *.edge setl shiftwidth=2 tabstop=2 noexpandtab
au BufWinEnter *.html setl shiftwidth=2 tabstop=2 noexpandtab
" au BufWinEnter *.cpp setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.ino setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.c setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.h setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.hpp setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.ex setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.exs setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.md setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.tsx setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.jsx setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.ts setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.js setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.asd setl shiftwidth=2 tabstop=2 expandtab
" au BufWinEnter *.lisp setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.go setl shiftwidth=4 tabstop=4
au BufWinEnter *.lua setl shiftwidth=3 tabstop=3 expandtab
