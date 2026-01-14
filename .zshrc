[[ $- != *i* ]] && return

if [[ ":$FPATH:" != *":/home/beed/.zsh/completions:"* ]]; then export FPATH="$HOME/.local/share/scalacli/completions/zsh:$HOME/.zsh/completions:$FPATH"; fi

export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
export PATH=$HOME/.volta/bin:$PATH
export PATH=$HOME/.go/bin:$PATH
export PATH=$HOME/.cache/scalacli/local-repo/bin/scala-cli:$PATH
export PATH=$HOME/.local/share/coursier/bin:$PATH
export PATH=$HOME/.atuin/bin:$PATH

export SDKMAN_DIR="$HOME/.sdkman"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

typeset -U PATH

set -o vi

PROMPT_COMMAND='history -a'
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '

export MANPAGER='nvim +Man!'
export BAT_THEME="Catppuccin Mocha"
export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --color=bg:-1,bg+:-1,preview-bg:-1"
export JAVA_HOME="$(dirname "$(dirname "$(readlink -f /usr/bin/java)")")"
export GOPATH=$HOME/.go

alias topen="~/.local/scripts/sesh-launcher"
alias peaclock='peaclock --config-dir ~/.config/peaclock'
alias vim="/usr/local/bin/nvim"
alias vimff="/usr/local/bin/nvim -c 'Telescope find_files'"
alias vi="/usr/bin/vim"
alias ls='eza'
alias tree='eza --tree'
alias cat='bat -p'
alias mkdir='mkdir -v'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias python="python3"
alias apt="sudo apt"
alias grep='grep --color=auto'

alias fonts='fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E "s/(^: |:)//g" | tr , \\n | sort  | uniq'
alias zadd="find . -maxdepth 1 -type d ! -name '.' -exec zoxide add {} \;"
alias largefiles="sudo find / -xdev -type f -size +500M -exec ls -lh {} \;"

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

zinit load atuinsh/atuin

zstyle ':fzf-tab:*' fzf-flags \
  --color=bg:-1,bg+:-1,preview-bg:-1

autoload -Uz compinit
compinit -C

zinit cdreplay -q
