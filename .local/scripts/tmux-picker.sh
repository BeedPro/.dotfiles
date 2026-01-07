#!/usr/bin/env bash

set -euo pipefail

DEPTH="${1:-2}"
PREFIX="${2:-}"

SEL="$(
  find . \
    -mindepth "$DEPTH" \
    -maxdepth "$DEPTH" \
    -type d \
    -printf "%P\n" \
    | tee >(xargs -r zoxide add) \
    | fzf
)"

CURRENT_SESSION="$(tmux display-message -p '#S')"

[ -z "$SEL" ] && tmux kill-session -t "$CURRENT_SESSION"

SESSION_NAME=$PREFIX$SEL
TARGET_PATH="$(pwd)/$SEL"

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux new-session -d -s "$SESSION_NAME" -c "$TARGET_PATH"
  tmux switch-client -t "$SESSION_NAME"
fi
tmux kill-session -t "$CURRENT_SESSION"
