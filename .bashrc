# ignores duplicate commands in history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# gor setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# bashh options
shopt -s histappend      
shopt -s lithist          
shopt -s checkwinsize   
shopt -s checkjobs     
shopt -s autocd       
shopt -s cdspell     
shopt -s no_empty_cmd_completion 
shopt -s dirspell               
shopt -s globstar              
shopt -s extglob              


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

# system global variables
export SHELL="${SHELL:-/bin/bash}"
export LANG="${LANG:-C.UTF-8}"
export LC_CTYPE="${LC_CTYPE:-C.UTF-8}"

# tools settings
export BAT_THEME='Nord'
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" | sed "s/^\.\///"'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export EDITOR="vim"
export PNPM_HOME="${HOME}/.local/share/pnpm"
export ERL_MAX_PORTS=1024

# XDG variables to clean ${HOME}
export XDG_STATE_HOME="${HOME}/.local/state"
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/python_history"

mkdir -vp "${HISTFILE%/*}" "${PYTHON_HISTORY%/*}"

# path config
export PATH="${PATH}:/bin:/usr/bin:/usr/local/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${PNPM_HOME}"                                         
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:/usr/bin/vendor_perl"
export PATH="${PATH}:${HOME}/.nix-profile/bin"

# most used / short aliasses
alias e='exit'
alias r='rm -vrf'
alias g='git'
alias l='ls -lh --group-directories-first --color=auto'
alias ll='ls -lhA --group-directories-first --color=auto'
alias cp='cp -vr'
alias md='mkdir -vp'
alias exe='chmod +x'
alias {v,n,nvim}='vim'
alias t='tmux'

# fixing behavior and customization
alias grep='grep --colour=auto'
alias diff='diff --colour=auto'
alias tree='tree --dirsfirst -aF -I .git -I node_modules -I target -I .mypy_cache -I __pycache__ -I .venv'
alias fzf="fzf --border sharp --margin 5% --info inline --prompt 'SEARCH: ' --pointer '**' --ansi --color 'bg+:-1,pointer:green,fg+:green,hl:yellow,border:gray'"

# python relared aliases
alias py='python3'
alias pip='python3 -m pip'
alias venv="python -m venv '.venv' && source './.venv/bin/activate'"
alias server='python3 -m http.server 8080'
alias calc='python3 -i <(echo "from math import *; from statistics import *")'

# custom solutions with aliasses
alias vf='vim $(fzf)'
alias temp='T="/tmp/${USER}/$(date "+%y%M%S-%H%M%s")"; mkdir -vp "${T}"; cd "${T}"; unset T'
alias {homectl,home}='make --makefile ${HOME}/.local/lib/homectl/Makefile'
alias {dotfiles,dot}="git --git-dir=\${HOME}/.local/share/git/dotfiles.git --work-tree=\${HOME}"

__powerline() {
  #POWERLINE_GIT=0  # Uncomment to disable git info

  # colors
  COLOR_RESET='\[\033[m\]'
  COLOR_CWD=${COLOR_CWD:-'\[\033[0;34m\]'} # blue
  COLOR_GIT=${COLOR_GIT:-'\[\033[0;36m\]'} # cyan
  COLOR_SUCCESS=${COLOR_SUCCESS:-'\[\033[0;32m\]'} # green
  COLOR_FAILURE=${COLOR_FAILURE:-'\[\033[0;31m\]'} # red

  # symbols
  PS_SYMBOL='λ'
  SYMBOL_GIT_BRANCH=${SYMBOL_GIT_BRANCH:-⑂}
  SYMBOL_GIT_MODIFIED=${SYMBOL_GIT_MODIFIED:-*}
  SYMBOL_GIT_PUSH=${SYMBOL_GIT_PUSH:-↑}
  SYMBOL_GIT_PULL=${SYMBOL_GIT_PULL:-↓}

  __git_info() {
    [[ ${POWERLINE_GIT:-0} = 0 ]] && return  # disabled
    hash git 2>/dev/null || return           # git not found

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

    # check the exit code of the previous command and display different colors in the prompt accordingly.
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]
    then
      symbol="${COLOR_SUCCESS} ${PS_SYMBOL} ${COLOR_RESET}"
    else
      symbol="${COLOR_FAILURE} ${PS_SYMBOL} ${COLOR_RESET}"
    fi

    cwd="${COLOR_CWD}\w${COLOR_RESET}"

    # POC: https://github.com/njhartwell/pw3nage
    # related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
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
