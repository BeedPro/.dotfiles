#!/usr/bin/env bash

SRC_DIR="$HOME/.local/src"
# Navigate to ~/.local/src and add directories (author/project) to zoxide, going two levels deep
cd ~/.local/src && find . -mindepth 2 -maxdepth 2 -type d | xargs -I {} zoxide add {}

# Now filter sesh list to show only those directories
selected=$(sesh list --icons | grep -E "~/.local/src/([^/]+/[^/]+)$" | fzf-tmux -p 80%,70% \
  --no-sort --ansi --border-label ' sesh ' --prompt 'src ' \
  --bind 'tab:down,btab:up' \
  --border=sharp \
  --preview-border=left \
  --no-scrollbar \
  --preview-window 'right:55%' \
  --layout 'reverse' \
  --preview 'sesh preview {}')


if [[ -n "$selected" ]]; then
  relative_path=$(echo $selected | sed 's|^[^ ]* ~/.local/src/||')
  session_name=$relative_path
  target="$SRC_DIR/$relative_path"

  # Create a tmux session and switch to it
   tmux new-session -ds "$session_name" -c "$target" && \
   tmux switch-client -t "$session_name"
   tmux kill-session -t "src"
   exit $?
fi
