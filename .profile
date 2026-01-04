# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

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
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/games
export MPD_HOST=/tmp/mpd_socket
export MANPAGER='nvim +Man!'
export BAT_THEME="Catppuccin Mocha"
export BEMENU_OPTS='--fn "GohuFont 14 Nerd Font [12]" --bdr "#b4befe" --fb "#1e1e2e" --ff "#cdd6f4" --nb "#1e1e2e" --nf "#cdd6f4" --tb "#b4befe" --hb "#b4befe" --tf "#1e1e2e" --hf "#1e1e2e" --af "#cdd6f4" --ab "#1e1e2e" -c -l 16 -W 0.5 -B 1 -m -1 -i'

export PATH="$PATH:/home/beed/.cache/scalacli/local-repo/bin/scala-cli"

# >>> coursier install directory >>>
export PATH="$PATH:/home/beed/.local/share/coursier/bin"
# <<< coursier install directory <<<

typeset -U PATH
