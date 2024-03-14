function __vi_enter_normal_mode -d 'bind (ctrl) for enter in normal mode'
    if commandline -P
        commandline -f cancel
    else
        set fish_bind_mode default
        commandline -f backward-char force-repaint
    end
end

bind -M insert \cp __vi_enter_normal_mode

function __attach_tmux_session -d 'bind (alt) select a session to attach'
    tmux attach -c (tmux ls | fzf --preview '' | cut -d: -f1)
end

bind -M insert \ea __attach_tmux_session

function __select_and_load_tmuxifier_session -d 'bind (alt) attach a session'
    type tmuxifier &>/dev/null &&
        tmuxifier load-session (tmuxifier list-sessions | fzf --preview '')
end

bind -M insert \eL __select_and_load_tmuxifier_session

function __create_new_tmuxifier_session -d 'bind (alt) create new session file'
    read -P 'fish (read) : specify a session name: ' r_session_name

    type tmuxifier &>/dev/null &&
        EDITOR=nvim tmuxifier new-session "$r_session_name"
end

bind -M insert \ef __create_new_tmuxifier_session

function __edit_tmuxifier_session -d 'bind (alt) edit a session file'
    type tmuxifier &>/dev/null &&
        EDITOR=nvim tmuxifier edit-session (tmuxifier list-sessions |
                                            fzf --preview '')
end

bind -M insert \ee __edit_tmuxifier_session

function __remove_tmuxifier_session_file -d 'bind (alt) delete an session file'
    set TMUXIFIER_LAYOUTS_D "$HOME/.tmux/plugins/tmuxifier/layouts"

    type tmuxifier &>/dev/null &&
        rm $TMUXIFIER_LAYOUTS_D/(tmuxifier list-sessions |
                                 fzf --preview '').session.sh
end

bind -M insert \ed __remove_tmuxifier_session_file
