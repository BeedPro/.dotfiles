export FZF_DEFAULT_OPTS=" \
--color=bg:#090E13,bg+:#393B44,spinner:#b6927b,hl:#c4746e \
--color=fg:#C5C9C7,header:#8ba4b0,info:#8ea4a2,pointer:#a292a3 \
--color=marker:#8a9a7b,fg+:#C5C9C7,prompt:#8ba4b0,hl+:#e46876 \
--color=selected-bg:#393B44 \
--color=border:#A4A7A4,label:#C5C9C7"

tmux set-environment -g FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS" 2>/dev/null
