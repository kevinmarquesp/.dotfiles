set autoindent noexpandtab smartindent breakindent linebreak
set shiftwidth=4 tabstop=4 formatoptions=1

autocmd BufNewFile,BufRead *.md set textwidth=80

au BufWinEnter *.templ setl shiftwidth=2 tabstop=2
au BufWinEnter *.edge setl shiftwidth=2 tabstop=2
au BufWinEnter *.html setl shiftwidth=2 tabstop=2
au BufWinEnter *.cpp setl shiftwidth=2 tabstop=2
au BufWinEnter *.ino setl shiftwidth=2 tabstop=2
au BufWinEnter *.c setl shiftwidth=2 tabstop=2
au BufWinEnter *.h setl shiftwidth=2 tabstop=2
au BufWinEnter *.hpp setl shiftwidth=2 tabstop=2
au BufWinEnter *.ex setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.exs setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.md setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.tsx setl shiftwidth=2 tabstop=2 expandtab
au BufWinEnter *.jsx setl shiftwidth=2 tabstop=2 expandtab

au BufWinEnter *.lua setl shiftwidth=3 tabstop=3 expandtab
