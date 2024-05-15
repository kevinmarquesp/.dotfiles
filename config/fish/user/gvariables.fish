set -gx BAT_THEME "Nord"
set -gx FZF_DEFAULT_COMMAND 'find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" | sed "s/^\.\///"'
set -gx EDITOR "vim"
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

set -gx PNPM_HOME "$HOME/.local/share/pnpm"

set -gx PATH "/bin:/usr/bin:/usr/local/bin"
set -gx PATH "$PATH:$HOME/.local/bin"
set -gx PATH "$PATH:$PNPM_HOME"
set -gx PATH "$PATH:$HOME/go/bin"
set -gx PATH "$PATH:$HOME/.tmux/plugins/tmuxifier/bin"

set -gx ERL_MAX_PORTS "1024"
