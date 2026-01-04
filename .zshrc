# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/beed/.zsh/completions:"* ]]; then export FPATH="/home/beed/.zsh/completions:$FPATH"; fi
#
# ~/.zshrc
#

# Only proceed if running interactively
[[ $- != *i* ]] && return

CONFIG_PATH="$HOME/.config/shell"

# Options
set -o vi

PROMPT_COMMAND='history -a'
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '

alias peaclock='peaclock --config-dir ~/.config/peaclock'
alias vim="/usr/local/bin/nvim"
alias vi="/usr/bin/vim"
alias ls='eza'
alias tree='eza --tree'
alias cat='bat -p'
alias mkdir='mkdir -v'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
alias python="python3"
alias grep='grep --color=auto'
alias fonts='fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E "s/(^: |:)//g" | tr , \\n | sort  | uniq'
alias cd='>/dev/null cd'
alias zadd="find . -maxdepth 1 -type d ! -name '.' -exec zoxide add {} \;"
alias apt="sudo apt"
alias pkgm="dotman distro"
alias yay="dotman yay"

export MANPAGER='nvim +Man!'
export BAT_THEME="Catppuccin Mocha"
export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
export JAVA_HOME="$(dirname "$(dirname "$(readlink -f /usr/bin/java)")")"

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit load atuinsh/atuin

if [ "$(hostname)" = "nimbus" ] && [ "$XDG_SESSION_TYPE" = "x11" ]; then
    xrdb -merge <<< "Xcursor.size: 24"
    xsetroot -cursor_name left_ptr
fi

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# >>> scala-cli completions >>>
fpath=("/home/beed/.local/share/scalacli/completions/zsh" $fpath)
compinit
# <<< scala-cli completions <<<

typeset -U PATH
