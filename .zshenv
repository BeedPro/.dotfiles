if [ -f "$HOME/.deno/env" ]; then
  . "$HOME/.deno/env"
fi
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
export GOPATH=$HOME/.go
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin
export PATH=$PATH:$HOME/.go/bin
export PATH=$PATH:$HOME/.config/emacs/bin
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/games
export DOTNET_ROOT=/opt/dotnet-sdk-9.0.305-linux-x64
export PATH=$PATH:$DOTNET_ROOT
export PATH=$PATH:$HOME/.dotnet/tools
export MPD_HOST=/tmp/mpd_socket
export BEMENU_OPTS='--fn "GohuFont 14 Nerd Font [12]" --bdr "#b4befe" --fb "#1e1e2e" --ff "#cdd6f4" --nb "#1e1e2e" --nf "#cdd6f4" --tb "#b4befe" --hb "#b4befe" --tf "#1e1e2e" --hf "#1e1e2e" --af "#cdd6f4" --ab "#1e1e2e" -c -l 16 -W 0.5 -B 1 -m -1 -i'
