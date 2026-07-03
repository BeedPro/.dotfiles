export FZF_DEFAULT_OPTS=" \
--color=bg:#ffffff,bg+:#a6a6a6,spinner:#884900,hl:#a60000 \
--color=fg:#000000,header:#0031a9,info:#005e8b,pointer:#721045 \
--color=marker:#006800,fg+:#000000,prompt:#0031a9,hl+:#972500 \
--color=selected-bg:#a6a6a6 \
--color=border:#a6a6a6,label:#595959"

tmux set-environment -g FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS" 2>/dev/null
