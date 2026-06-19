[[ $- != *i* ]] && return

export EDITOR=nvim

export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.volta/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.cache/scalacli/local-repo/bin/scala-cli:$PATH"
export PATH="$HOME/.local/share/coursier/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export SDKMAN_DIR="$HOME/.sdkman"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if [[ 1 -eq $__ETC_PROFILE_NIX_SOURCED ]] && ! type -p nix-shell > /dev/null; then unset __ETC_PROFILE_NIX_SOURCED && source /etc/profile.d/nix.sh; fi

set -o vi

shopt -s histappend
export HISTSIZE=500000
export HISTFILESIZE=500000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export HISTTIMEFORMAT='%F %T '

export MANPAGER='nvim +Man!'
source $HOME/.config/fzf/themes/dark.sh

export JAVA_HOME="$(dirname "$(dirname "$(readlink -f /usr/bin/java)")")"
export GOPATH="$HOME/.go"

alias peaclock='peaclock --config-dir ~/.config/peaclock'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias tree='eza --tree'
else
  alias ls='ls --color=auto'
  alias tree='tree -C'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --theme=Dark -p'
fi

alias mkdir='mkdir -v'
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'

alias grep='grep --color=auto'
alias python='python3'
alias fonts='fc-list | grep -ioE ": [^:]*$1[^:]+:" | sed -E "s/(^: |:)//g" | tr , "\n" | sort | uniq'

alias largefiles='sudo find . -xdev -type f -size +500M -printf "%10s %TY-%Tm-%Td %TH:%TM %p\n" 2>/dev/null \
| sort -nr \
| numfmt --to=iec --suffix=B --padding=7 --field=1'
alias countfiles='sudo bash -c '\''for t in files links directories; do echo $(find . -type ${t:0:1} 2>/dev/null | wc -l) $t; done'\'''
alias diskspace='sudo bash -c '\''du -S . 2>/dev/null | sort -nr | less'\'''
alias folders='sudo du -h --max-depth=1 . 2>/dev/null'
alias foldersort='sudo bash -c '\''find . -maxdepth 1 -type d -print0 2>/dev/null | xargs -0 du -sk | sort -rn'\'''
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

eval "$(fzf --bash)"

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi

export VIRTUAL_ENV_DISABLE_PROMPT=1

# https://unix.stackexchange.com/questions/767621/i-cant-get-bash-history-to-update-instantly-in-all-terminals
PROMPT='
PS1_VENV=${VIRTUAL_ENV:+($(basename "$VIRTUAL_ENV")) }
if declare -F __git_ps1 >/dev/null; then
  PS1_CMD1=$(__git_ps1 "\n[%s]")
else
  PS1_CMD1=
fi
'

PS1='\[\e[92m\]\u@\h\[\e[0m\]:\[\e[96m\]\w\[\e[0m\]\[\e[95m\]${PS1_CMD1}\[\e[0m\]\n\[\e[93m\]${PS1_VENV}\[\e[0m\]> '

PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/home/beed/.opencode/bin:$PATH
