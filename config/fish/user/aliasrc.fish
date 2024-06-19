## SHARED ALIASRC WITH BASH:
## 	This weird comments will be read by a function that will convert this aliasrc
##  fish file to a Bash compatible one. I think it's quite simple to understand,
##  but let me explain:
##
##  Every line that ends with a '#bign!' ("bash ignore") will be excluded on the
##  convertion, and the '#binc:' ("bash include") will be added. Not only that,
##  this special syntax expects that the conversor also concatenates the lines
##  that ends with the '\' character before duing the convertion.

alias r  'rm -rf'
alias n  'nvim'
alias v  'vim'
alias e  'exit'
alias f  'ranger'
alias t  'tmux'
alias ct 'mkdir /tmp/tmp.kevin; cd /tmp/tmp.kevin'
alias md 'mkdir -vp'
alias cp 'cp -r'

#binc: alias ..="cd .."
#binc: alias ...="cd ../.."

alias g    'git'
abbr  gac  'git commit --amend -m (git log -1 --format="%s")'
abbr  gaac 'git add :; git commit --amend -m (git log -1 --format="%s")'

alias grep 'grep --colour=auto'
alias bat  'batcat'

alias tree 'exa --tree --icons --group-directories-first -aF --ignore-glob=".git|node_modules|target|.mypy_cache|__pycache__|.venv"'  #bign!
alias ll   'exa -lam --no-user --time-style long-iso --group-directories-first -s extension --icons'  #bign!
alias l    'exa -lm --no-user --time-style long-iso --group-directories-first -s extension --icons'  #bign!

#binc: alias tree='tree --dirsfirst -aF -I .git -I node_modules -I target -I .mypy_cache -I __pycache__ -I .venv'
#binc: alias ll="ls -lhA --color=auto"
#binc: alias l="ls -lh --color=auto"

alias tf 'tmuxifier'

abbr py       'python3'
abbr pip      'python3 -m pip'
abbr pyserver 'python3 -m http.server 8080'

abbr ard-comp      'arduino-cli compile -u -b arduino:avr:uno -p /dev/ttyUSB0'
abbr ard-ls        'arduino-cli board list'
abbr ard-install   'arduino-cli lib install'
abbr ard-uninstall 'arduino-cli lib uninstall'
abbr ard-new       'arduino-cli sketch new'

alias fzf 'fzf --preview "batcat --color=always --style=numbers \
                                 --line-range=:500 {}" \
               --ansi \
               --border sharp \
               --margin 5% \
               --info inline \
               --prompt "   " \
               --pointer "->" \
               --color "bg+:-1,pointer:green,fg+:green,hl:yellow,border:gray"'  #bign!

#binc: alias fzf="fzf --border sharp --margin 5% --info inline \
#binc:            --prompt 'SEARCH: ' --pointer '**' --ansi \
#binc:            --color 'bg+:-1,pointer:green,fg+:green,hl:yellow,border:gray'"

abbr exe 'chmod +x'
abbr vf  'vim (fzf)'
abbr nf  'nvim (fzf)'
abbr bf  'bat (fzf)'

abbr  todo 'echo [TODO]'  #bign!
alias done 'set F ~/.local/share/fish/fish_history;set T ~/.cache/fh.yml;set L (rg -nj12 \'^- cmd: echo \[TODO\] ?.+$\' $F|sed \'s/- cmd: echo//\'|fzf --preview-window=hidden|cut -d: -f1);[ -n"$L" ]&&sed $L"s/\(- cmd: echo \)\[TODO\]/\1[DONE]/" $F>$T&&cat $T>$F&&exec fish' #bign!
abbr  todols 'history|rg -j12 \'^echo \[TODO\] ?.+$\'|sed \'s/^echo //\''  #bign!
abbr  donels 'history|rg -j12 \'^echo \[DONE\] ?.+$\'|sed \'s/^echo //\''  #bign!

if grep -q 'ID=arch' /etc/os-release
	abbr update    'sudo pacman -Syyuu'
	abbr uninstall 'sudo pacman -Rns'
	abbr install   'yay -S'
	abbr orphans   'sudo pacman -Rns (pacman -Qtdq)'
else
	abbr update    'sudo apt update && sudo apt upgrade'
	abbr uninstall 'sudo apt purge --autoremove'
	abbr install   'sudo apt install --no-install-recommends'
	abbr orphans   'sudo apt autoremove'
end
