#!/usr/bin/env bash


SRC_DIR="$HOME/.local/src"
mkdir -p "$SRC_DIR"

ensure_session () {
  # ensure_session <session_name> <dir>
  local sname="$1"
  local dir="$2"

  if ! tmux has-session -t "$sname" 2>/dev/null; then
    tmux new-session -ds "$sname" -c "$dir"
  fi

  tmux switch-client -t "$sname"
}

# Prompt the user with a fuzzy finder interface to select a session
selected=$(sesh list --icons | fzf-tmux -p 80%,70% \
  --ansi \
  --no-sort \
  --border-label ' sesh ' --prompt 'all ' \
  --header '  (C-a) all :: (C-t) tmux :: (C-g) config :: (C-x) zoxide :: (M-bs) kill' \
  --bind 'tab:down,btab:up' \
  --bind 'ctrl-a:change-prompt(all )+reload(sesh list --icons)' \
  --bind 'ctrl-t:change-prompt(ses )+reload(sesh list -t --icons)' \
  --bind 'ctrl-g:change-prompt(dir )+reload(sesh list -c --icons)' \
  --bind 'ctrl-x:change-prompt(zox )+reload(sesh list -z --icons)' \
  --bind 'alt-backspace:execute(tmux kill-session -t {2..})+change-prompt(all )+reload(sesh list --icons)' \
  --border=sharp \
  --preview-border=left \
  --no-scrollbar \
  --preview-window 'right:55%' \
  --layout 'reverse' \
  --print-query \
  --preview 'sesh preview {}' \
  --color=bg:-1,bg+:-1,gutter:-1
)

selected=$(echo "$selected" | tail -1)

# If the input looks like a Git URL, clone it
# Matches:
#   https://....
#   http://....
#   git@host:owner/repo.git
#   ssh://git@host/owner/repo.git
#   gh:owner/repo
if [[ "$selected" =~ ^(https?://|git@[^:]+:|ssh://git@[^/]+/|gh:) ]]; then

  # Extract "owner/repo" from most SSH/HTTPS formats
  # Handles:
  #   https://codeberg.org/Beed/testing-repo.git
  #   ssh://git@codeberg.org/Beed/testing-repo.git
  #   git@codeberg.org:Beed/testing-repo.git
  clean=$(echo "$selected" \
    | sed -E \
      -e 's#^ssh://git@[^/]+/##' \
      -e 's#^git@[^:]+:##' \
      -e 's#^https?://[^/]+/##' \
      -e 's#(.git)?$##' \
  )

  target="$SRC_DIR/$clean"

  if [[ ! -d "$target/.git" ]]; then
    mkdir -p "$(dirname "$target")"
    git clone "$selected" "$target" || exit $?
  fi

  ensure_session "$clean" "$target"
  exit $?
fi

selected=$(echo "$selected" | tail -1)

# Check if SRC_DIR is a substring of the selected path
if [[ "$selected" == *"~/.local/src"* ]]; then
  relative_path=$(echo $selected | sed 's|^[^ ]* ~/.local/src/||')
  session_name=$relative_path
  target="$SRC_DIR/$relative_path"

  # Create a tmux session and switch to it
   tmux new-session -ds "$session_name" -c "$target" && \
   tmux switch-client -t "$session_name"
   exit $?
fi

# If a session was selected, connect to it
if [[ -n "$selected" ]]; then
  sesh connect "$selected"
fi
