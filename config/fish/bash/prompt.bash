# ----------------------------------------------
# minimal bash prompt adapted from this article:
# http://www.daprose.de/article/minimal-git-bash-prompt

# bash color escape sequences
clr_rd=$'\001'$(tput setaf 1 2>/dev/null || echo $'\e[31m')$'\002'
clr_gr=$'\001'$(tput setaf 2 2>/dev/null || echo $'\e[32m')$'\002'
clr_bl=$'\001'$(tput setaf 4 2>/dev/null || echo $'\e[34m')$'\002'
clr_re=$'\001'$(tput sgr 0 2>/dev/null || echo $'\e[0m')$'\002'

# dereference git symbolic reference HEAD to get branch name or sha1 of commit
# object and amend by information about current status of staging area
function dereference_gi {
    local sha1
    sha1=$(git rev-parse --short HEAD 2>&1)

    if [ $? -eq 0 ]; then
        local clr_symref=$clr_gr
        local clr_ref=$clr_bl
        local dirty=$(git status --porcelain 2>&1)

        if [ ! -z "$dirty" ]; then
            clr_symref=$clr_rd
            clr_ref=$clr_rd
            dirty='*'
        fi

        GIT_HE="$clr_symref($(git symbolic-ref --quiet --short HEAD)$dirty)$clr_re "

        if [ $? -ne 0 ]; then
            GIT_HE="$clr_ref[$sha1$dirty]$clr_re"
        fi
    else
        GIT_HE=""
    fi
}

# run command before bash takes PS1 to build prompt
PROMPT_CO="dereference_gi; $PROMPT_CO"

if [ $USER = "root" ]; then  #test
    PS1="${clr_rd}[\u@\h] ${clr_re}\W ${GIT_HE}${clr_rd}# ${clr_re}"  #testing
else
    PS1="${clr_gr}[\u@\h] ${clr_re}\W ${GIT_HE}${clr_gr}\$ ${clr_re}"
fi
