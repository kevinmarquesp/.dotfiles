set fish_greeting  #- Avoid displaying the fish_greeting string every time I open the shell.

source "$HOME/.config/fish/user/gvariables.fish"  #- Global variables, some other applications/tools will use them.
source "$HOME/.config/fish/user/aliasrc.fish"     #- Custom alias/abbr list, straight forward...
source "$HOME/.config/fish/user/keybinds.fish"    #- Fish keybinds, my custom fish <alt> keybinds and modes.
source "$HOME/.config/fish/user/ucommands.fish"   #- User commands, a little utils tools collection written in fish function.

function fish_mode_prompt  #- Well... This fixes a weird visual bug, the VI mode indicator appears
end                        #- twice in the prompt, this lines avoid that for some reason...

fish_vi_key_bindings  #- Enables the VI mode, now I can use <c-p> to go into normal mode!


## FISHER INSTALLATION:
##  That's a cool section in my Fish config. If I'm oppening this shell in a new
##  machine that I hasn't installed the Fisher plugin manager, it will automatically
##  install Fisher for me and set everything up! How cool is that?

set FISH_HOME "$HOME/.config/fish"

if [ ! -f "$FISH_HOME/functions/fisher.fish" ]
  set FISHER_ORIGIN 'https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish'
  set FISHER_TARGET "$FISH_HOME/functions/fisher.fish"

  mkdir -p "$FISH_HOME/functions"
  curl -sL "$FISHER_ORIGIN" > "$FISHER_TARGET"

  fish -c 'fisher update' &&
  exec "fish"  #- Replaces the current Fish session to a new one
end


## APPLICATION SETTINGS & SETUP:
## 	The code below this section is just settings that other applications recommends
##  appending to this file. Some time or another I'll organize that stuff, but its
##  required to be clean...

#- Sourcing the ASDF script for fish shell (installed manually & from AUR).

[ -f "$HOME/.asdf/asdf.fish" ] &&
  source "$HOME/.asdf/asdf.fish"

[ -f "/opt/asdf-vm/asdf.fish" ] &&
  source "/opt/asdf-vm/asdf.fish"

#- Sourcing Xmake Fish profile.

[ -f "$HOME/.xmake/profile" ] &&
  source "$HOME/.xmake/profile"

#- Use the tmuxifier command to generate the code completion

if which tmuxifier &>/dev/null
  eval (tmuxifier init - fish)
end
