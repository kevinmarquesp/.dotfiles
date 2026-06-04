# ignores duplicate commands in history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# gor setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# update the values of LINES and COLUMNS
shopt -s checkwinsize

# match all files and zero or more directories and subdirectories
shopt -s globstar

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features
if ! shopt -oq posix
then
  if [[ -f /usr/share/bash-completion/bash_completion ]]
  then
    . /usr/share/bash-completion/bash_completion

  elif [[ -f /etc/bash_completion ]]
  then
    . /etc/bash_completion
  fi
fi

# tools settings
export BAT_THEME="Nord"
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" | sed "s/^\.\///"'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export EDITOR="vim"
export PNPM_HOME="${HOME}/.local/share/pnpm"
export ERL_MAX_PORTS="1024"

# XDG variables to clean ${HOME}
export XDG_STATE_HOME="${HOME}/.local/state"
export HISTFILE="${XDG_STATE_HOME}/bash/history"

# path config
export PATH="${PATH}:/bin:/usr/bin:/usr/local/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${PNPM_HOME}"                                         
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:/usr/bin/vendor_perl"
export PATH="${PATH}:${HOME}/.tmux/plugins/tmuxifier/bin"                  
export PATH="${PATH}:${HOME}/.config/emacs/bin"
export PATH="${PATH}:${HOME}/.nix-profile/bin"

# custom aliasses
alias homectl='make --makefile ${HOME}/.local/lib/homectl/Makefile'
alias dotfiles="git --git-dir=\${HOME}/.local/share/git/dotfiles.git --work-tree=\${HOME}"
alias r='rm -rf'
alias n='vim'  # basic bash environment should use vim always
alias v='vim'
alias e='exit'
alias ct='mkdir /tmp/tmp.kevin; cd /tmp/tmp.kevin'
alias md='mkdir -vp'
alias cp='cp -r'
alias ..="cd .."                                                       
alias cz="cz -n"
alias ...="cd ../.."
alias g='git'
alias grep='grep --colour=auto'
alias tree='tree --dirsfirst -aF -I .git -I node_modules -I target -I .mypy_cache -I __pycache__ -I .venv'
alias ll="ls -lhA --color=auto"
alias l="ls -lh --color=auto"
alias tf='tmuxifier'
alias py='python3'
alias pip='python3 -m pip'
alias pyserver='python3 -m http.server 8080'
alias ipy='ipython'
alias venv='python -m venv .venv && source ./.venv/bin/activate'
alias ard-comp='arduino-cli compile -u -b arduino:avr:uno -p /dev/ttyUSB0'
alias ard-ls='arduino-cli board list'
alias ard-install='arduino-cli lib install'
alias ard-uninstall='arduino-cli lib uninstall'
alias ard-new='arduino-cli sketch new'
alias fzf="fzf --border sharp --margin 5% --info inline --prompt 'SEARCH: ' --pointer '**' --ansi --color 'bg+:-1,pointer:green,fg+:green,hl:yellow,border:gray'"
alias exe='chmod +x'
alias vf='vim $(fzf)'
alias nf='nvim $(fzf)'
alias bf='bat $(fzf)'

__powerline() {
  #POWERLINE_GIT=0  # Uncomment to disable git info

  # Colors
  COLOR_RESET='\[\033[m\]'
  COLOR_CWD=${COLOR_CWD:-'\[\033[0;34m\]'} # blue
  COLOR_GIT=${COLOR_GIT:-'\[\033[0;36m\]'} # cyan
  COLOR_SUCCESS=${COLOR_SUCCESS:-'\[\033[0;32m\]'} # green
  COLOR_FAILURE=${COLOR_FAILURE:-'\[\033[0;31m\]'} # red

  # Symbols
  SYMBOL_GIT_BRANCH=${SYMBOL_GIT_BRANCH:-⑂}
  SYMBOL_GIT_MODIFIED=${SYMBOL_GIT_MODIFIED:-*}
  SYMBOL_GIT_PUSH=${SYMBOL_GIT_PUSH:-↑}
  SYMBOL_GIT_PULL=${SYMBOL_GIT_PULL:-↓}

  if [[ -z "${PS_SYMBOL}" ]]; then
    case "$(uname)" in
      Darwin)   PS_SYMBOL='';;
      Linux)    PS_SYMBOL='$';;
      *)        PS_SYMBOL='%';;
    esac
  fi

  __git_info() {
    [[ ${POWERLINE_GIT:-0} = 0 ]] && return  # disabled
    hash git 2>/dev/null || return      # git not found

    local git_eng ref

    git_eng="env LANG=C git"                                 # force git output in English to make our work easier
    ref=$(${git_eng} symbolic-ref --short HEAD 2>/dev/null)  # get current branch name

    if [[ -n "${ref}" ]]
    then
      ref=${SYMBOL_GIT_BRANCH}${ref}  # prepend branch symbol
    else
      ref=$(${git_eng} describe --tags --always 2>/dev/null)  # get tag name or short unique hash
    fi

    [[ -n "${ref}" ]] || return  # not a git repo

    local marks

    while IFS= read -r line  # scan first two lines of output from `git status`
    do
      if [[ ${line} =~ ^## ]]  # header line
      then
        [[ ${line} =~ ahead\ ([0-9]+) ]] &&
          marks+=" ${SYMBOL_GIT_PUSH}${BASH_REMATCH[1]}"
        [[ ${line} =~ behind\ ([0-9]+) ]] &&
          marks+=" ${SYMBOL_GIT_PULL}${BASH_REMATCH[1]}"
      else  # branch is modified if output contains more lines after the header line
        marks="${SYMBOL_GIT_MODIFIED}${marks}"
        break
      fi
    done < <(${git_eng} status --porcelain --branch 2>/dev/null) || true  # note the space between the two <

    printf " %s%s" "${ref}" "${marks}"  # print the git branch segment without a trailing newline
  }

  ps1() {
    local symbol cwd git

    # Check the exit code of the previous command and display different
    # colors in the prompt accordingly.
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]
    then
      symbol="${COLOR_SUCCESS} ${PS_SYMBOL} ${COLOR_RESET}"
    else
      symbol="${COLOR_FAILURE} ${PS_SYMBOL} ${COLOR_RESET}"
    fi

    cwd="${COLOR_CWD}\w${COLOR_RESET}"

    # POC: https://github.com/njhartwell/pw3nage
    # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
    if shopt -q promptvars
    then
      __powerline_git_info="$(__git_info)"
      git="${COLOR_GIT}\${__powerline_git_info}${COLOR_RESET}"
    else
      git="${COLOR_GIT}$(__git_info)${COLOR_RESET}"  # promptvars is disabled. Avoid creating unnecessary env var.
    fi

    PS1="${cwd}${git}${symbol}"
  }

  PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; ${PROMPT_COMMAND}}"
}

__powerline
unset __powerline

# shellcheck disable=SC2312
eval "$(mise activate bash)" 
