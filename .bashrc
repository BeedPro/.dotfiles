[[ $- != *i* ]] && return

export EDITOR=nvim

export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.volta/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.cache/scalacli/local-repo/bin/scala-cli:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"

export SDKMAN_DIR="$HOME/.sdkman"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

set -o vi

shopt -s histappend
export HISTSIZE=500000
export HISTFILESIZE=500000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export HISTTIMEFORMAT='%F %T '

export MANPAGER='nvim +Man!'
source $HOME/.config/fzf/light.sh

export JAVA_HOME="$(dirname "$(dirname "$(readlink -f /usr/bin/java)")")"
export GOPATH="$HOME/.go"

alias t="tmux a || tmux"
alias topen="$HOME/.local/scripts/sesh-launcher"

cdi() {
    local dir
    dir="$("$HOME/.local/scripts/sesh-launcher" -o </dev/tty)" || return
    cd "$dir"
    clear
}

alias peaclock='peaclock --config-dir ~/.config/peaclock'

alias vim="/usr/local/bin/nvim"
alias svim="sudo -E /usr/local/bin/nvim"

if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias tree='eza --tree'
else
  alias ls='ls --color=auto'
  alias tree='tree -C'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --theme gruvbox-light -p'
fi

alias mkdir='mkdir -v'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'

alias python='python3'
alias apt='sudo apt'
alias grep='grep --color=auto'

alias fonts='fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E "s/(^: |:)//g" | tr , "\n" | sort | uniq'
alias largefiles='sudo find / -xdev -type f -size +500M -exec ls -lh {} \;'
eval "$(fzf --bash)"

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1

# https://unix.stackexchange.com/questions/767621/i-cant-get-bash-history-to-update-instantly-in-all-terminals
PROMPT='
PS1_VENV=${VIRTUAL_ENV:+($(basename "$VIRTUAL_ENV")) }
PS1_CMD1=$(__git_ps1 ":%s")
'

PS1='\[\e[92m\]\u@\h\[\e[0m\]:\[\e[96m\]\w\[\e[0m\]${PS1_CMD1}\n\[\e[93m\]${PS1_VENV}\[\e[0m\]> '

PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT"
