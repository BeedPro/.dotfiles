[[ $- != *i* ]] && return

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
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
export JAVA_HOME="$(dirname "$(dirname "$(readlink -f /usr/bin/java)")")"

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
alias apt="sudo apt"

alias fonts='fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E "s/(^: |:)//g" | tr , \\n | sort  | uniq'
alias zadd="find . -maxdepth 1 -type d ! -name '.' -exec zoxide add {} \;"
alias largefiles="sudo find / -xdev -type f -size +500M -exec ls -lh {} \;"

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"

source $HOME/.config/fzf/bash-completion.sh
bind -x '"\t": fzf_bash_completion'

PATH="$(awk -v RS=: '!a[$0]++ { if (NR>1) printf ":"; printf "%s",$0 }' <<< "$PATH")"
export PATH
