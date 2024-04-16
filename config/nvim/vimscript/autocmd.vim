" LSP Replacement:
"	Execute the `ctags` command that allows Vim to jump into tag (functions,
"	variables, types, etc.) definitions like it's using some LSP server.
command! UserMakeTags !ctags -R --exclude=.git --exclude=node_modules

" Auto Generate The Vimrc File:
"	A little hack that will concatenate every vimscript file that my Neovim
"	uses to setup the basic stuff, so both my Neovim and Vim can share the same
"	configuration files in some way.
command! UserMakeVimrc !cat ~/.config/nvim/vimscript/*.vim | sed -e '/^ *$/d;/^".*/d' > ~/.vimrc
