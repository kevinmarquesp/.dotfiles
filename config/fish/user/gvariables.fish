set -gx BAT_THEME "Nord"
set -gx FZF_DEFAULT_COMMAND 'find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" | sed "s/^\.\///"'
set -gx EDITOR "nvim"  #bign!
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

#binc: export EDITOR="vim"

set -gx PNPM_HOME "$HOME/.local/share/pnpm"

set -gx PATH "/bin:/usr/bin:/usr/local/bin"
set -gx PATH "$PATH:$HOME/.local/bin"
set -gx PATH "$PATH:$PNPM_HOME"
set -gx PATH "$PATH:$HOME/go/bin"
set -gx PATH "$PATH:/usr/bin/vendor_perl"
set -gx PATH "$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
set -gx PATH "$PATH:$HOME/.config/emacs/bin"

set -gx ERL_MAX_PORTS "1024"
