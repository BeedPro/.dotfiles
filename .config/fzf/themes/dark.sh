export FZF_DEFAULT_OPTS=" \
--color=bg:#000000,bg+:#2f3849,spinner:#efef00,hl:#ff5f59 \
--color=fg:#ffffff,header:#2fafff,info:#00d3d0,pointer:#feacd0 \
--color=marker:#44bc44,fg+:#ffffff,prompt:#2fafff,hl+:#ff5f5f \
--color=selected-bg:#2f3849 \
--color=border:#646464,label:#989898"

tmux set-environment -g FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS" 2>/dev/null
