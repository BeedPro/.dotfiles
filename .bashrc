#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

shopt -s checkwinsize
bind Space:magic-space
shopt -s globstar 2> /dev/null

bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

shopt -s histappend
shopt -s cmdhist

PROMPT_COMMAND='history -a'
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

shopt -s autocd 2> /dev/null
shopt -s dirspell 2> /dev/null
shopt -s cdspell 2> /dev/null

CDPATH="."

shopt -s cdable_vars

export dotfiles="$HOME/.dotfiles"
export src="$HOME/.local/src"
export dev="$HOME/.local/src/BeedPro"

alias peaclock='peaclock --config-dir ~/.config/peaclock'
alias agim="/usr/local/bin/nvim -c ':Org agenda d'"
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
alias vim='/usr/local/bin/nvim'
alias vi='/usr/bin/vim'
alias zadd='ls -d */ | xargs -I {} zoxide add {}'
alias apt="sudo apt"
alias pkgm="dotman distro"
alias yay="dotman yay"

# PS1='[\u@\h \W]\$ '
PS1='\W \$ '

export MANPAGER='nvim +Man!'
export BAT_THEME="Catppuccin Mocha"
export STARSHIP_CONFIG=$HOME/.config/starship/config.toml
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
export JAVA_HOME="$(dirname "$(dirname "$(readlink -f /usr/bin/java)")")"

if [[ -f "$HOME/.local/bin/env" ]]; then
    . "$HOME/.local/bin/env"
fi

if [[ -f "$HOME/.atuin/bin/env" ]]; then
    . "$HOME/.atuin/bin/env"
fi
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash --cmd cd)"
fi

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi
source $HOME/.config/fzf/bash-completion.sh
bind -x '"\t": fzf_bash_completion'

if [ "$(hostname)" = "nimbus" ] && [ "$XDG_SESSION_TYPE" = "x11" ]; then
    xrdb -merge <<< "Xcursor.size: 24"
    xsetroot -cursor_name left_ptr
fi

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/completions/git
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
    source /etc/bash_completion.d/git
  fi
fi

if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" > /dev/null
fi
. "$HOME/.cargo/env"
[[ -s "$HOME/.local/share/bash-completion/completions/deno.bash" ]] && source $HOME/.local/share/bash-completion/completions/deno.bash

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

typeset -U PATH
