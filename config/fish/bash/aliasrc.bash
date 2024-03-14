##note: These aliasses is meant to be exclusive to bash, the objective of this
##note: approach is jsut to make the bash be a minimal shell but still pretty
##note: functional

alias ..="cd .."
alias ...="cd ../.."

alias ll="ls -lhA --color=auto"
alias l="ls -lh --color=auto"

alias fzf="fzf --border sharp --margin 10% --padding 5% --info inline        \
               --prompt 'SEARCH: ' --pointer '**' --ansi                     \
               --color 'bg+:-1,pointer:green,fg+:green,hl:yellow,border:gray'"

