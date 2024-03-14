set -gx BAT_THEME           'Nord'
set -gx FZF_DEFAULT_COMMAND 'find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" | sed "s/^\.\///"'
set -gx PNPM_HOME "$HOME/.local/share/pnpm"

set -gx EDITOR "vim"

set -gx PATH "/bin:/usr/bin:/usr/local/bin"
set -gx PATH "$PATH:$HOME/.local/bin"

set -gx PATH "$PATH:$PNPM_HOME"
set -gx PATH "$PATH:$HOME/go/bin"
set -gx PATH "$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
