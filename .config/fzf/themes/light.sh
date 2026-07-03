export FZF_DEFAULT_OPTS=" \
--color=bg:#ffffff,bg+:#dae5ec,spinner:#808000,hl:#a60000 \
--color=fg:#000000,header:#0031a9,info:#005e8b,pointer:#721045 \
--color=marker:#006800,fg+:#000000,prompt:#0031a9,hl+:#a0132f \
--color=selected-bg:#dae5ec \
--color=border:#9f9f9f,label:#595959"

tmux set-environment -g FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS" 2>/dev/null
