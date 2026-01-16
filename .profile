if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:/usr/games
export PATH=$PATH:/usr/local/go/bin
export MPD_HOST=/tmp/mpd_socket

[ -f "/home/beed/.ghcup/env" ] && . "/home/beed/.ghcup/env" # ghcup-env