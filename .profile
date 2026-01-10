if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.volta/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin
export PATH=$PATH:$HOME/.go/bin
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/games
export PATH="$PATH:/home/beed/.cache/scalacli/local-repo/bin/scala-cli"
export PATH="$PATH:/home/beed/.local/share/coursier/bin"
export GOPATH=$HOME/.go
export MPD_HOST=/tmp/mpd_socket

[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
