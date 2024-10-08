#!/usr/bin/env bash

function fatal() {
  echo -e "\n:: [FATAL] Something went wrong during this action :("
  echo -e "\t${2}"

  exit ${1}
}

which jq &>/dev/null || fatal 1 "Cannot proceed without the JQ dependency!"

jq -cr '.[]' <<<"[
  { \"source\": \"$(pwd)/home/.bashrc\",         \"target\": \"${HOME}/.bashrc\" },
  { \"source\": \"$(pwd)/home/.gitconfig\",      \"target\": \"${HOME}/.gitconfig\" },
  { \"source\": \"$(pwd)/home/.tmux.conf\",      \"target\": \"${HOME}/.tmux.conf\" },
  { \"source\": \"$(pwd)/home/.vimrc\",          \"target\": \"${HOME}/.vimrc\" },
  { \"source\": \"$(pwd)/config/fish\",          \"target\": \"${HOME}/.config/fish\" },
  { \"source\": \"$(pwd)/config/i3\",            \"target\": \"${HOME}/.config/i3\" },
  { \"source\": \"$(pwd)/config/nvim\",          \"target\": \"${HOME}/.config/nvim\" },
  { \"source\": \"$(pwd)/config/picom\",         \"target\": \"${HOME}/.config/picom\" },
  { \"source\": \"$(pwd)/config/rofi\",          \"target\": \"${HOME}/.config/rofi\" },
  { \"source\": \"$(pwd)/config/alacritty\",     \"target\": \"${HOME}/.config/alacritty\" },
  { \"source\": \"$(pwd)/vscode/settings.json\", \"target\": \"${HOME}/.config/Code/User/settings.json\" }
]" | while read -r data; do
  SOURCE=$(jq -r '.source' <<<"${data}")
  TARGET=$(jq -r '.target' <<<"${data}")

  # If the target is a link that is already pointed to the correct source, just skip it.

  if [ -h "${TARGET}" ]; then
    LINK=$(stat -c %N "${TARGET}" | sed "s/^'.*' -> '\(.*\)'$/\1/")

    if [ "${SOURCE}" = "${LINK}" ]; then
      echo ":: [INFO] '$(basename ${SOURCE})' is already linked to here. Skiping."
      continue
    fi
  fi

  # If the target already exists, move it to a unique (with the current timestamp) backup before linking.

  if [ -e "${TARGET}" ]; then
    BACKUP="${TARGET}.$(date +%s).backup"

    echo ":: [WARNING] This file already exists! A backup will be crated as '$(basename ${BACKUP})'."

    mv ${TARGET} ${BACKUP} ||
      fatal 1 "Error when creating the '${BACKUP}' backup..."
  fi

  # Just link the source in this repository to the desired target, simple as that.

  echo -e "\n:: Linking '${SOURCE}'..."

  ln -s ${SOURCE} ${TARGET} &&
    echo ":: Linked to '${TARGET}' with success!" ||
    fatal 1 "Could not link '${SOURCE}' to '${TARGET}'..."
done

# --------------------------------------------------------------------
# The script bellow is just to setup the configuration of the programs
# --------------------------------------------------------------------

if code --version &>/dev/null; then
  EXTENSIONS="$(pwd)/vscode/extensions.txt"

  echo -e "\n:: The VS Code binary was detected, it'll automatically install the extensions too."

  cat ${EXTENSIONS} |
    xargs -P12 -I{} -- bash -c 'code --install-extension {}'
else
  echo -n "\n:: [NOTE] Visual Studio Code was not installed!"
fi

if nvim --version &>/dev/null; then
  echo -e "\n:: The Neovim binary was detected, it'll setup the plugins, Treesitter and LSP automatically."

  nvim -c ":UserInstallLazy" -c ":q"
  nvim -c ":q"
else
  echo -n "\n:: [NOTE] Neovim was not installed!"
fi

if tmux -V &>/dev/null && git --version &>/dev/null; then
  echo -e "\n:: The Tmux binary was detected, the Plugins and themes will be automatically configured."

  git clone "https://github.com/tmux-plugins/tpm" "${HOME}/.tmux/plugins/tpm"
  bash "${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh"
else
  echo -n "\n:: [NOTE] Tmux was not installed!"
fi

if ! which cz &>/dev/null; then
  echo -e "\n:: The CZ script was not found, it'll be installed automatically."

  git clone https://github.com/kevinmarquesp/cz
  mkdir ~/.local/share/cz ~/.local/bin
  cp cz/cz.sh ~/.local/bin/cz
  cp cz/types.json ~/.local/share/cz/types.json
  rm -rf cz
fi
