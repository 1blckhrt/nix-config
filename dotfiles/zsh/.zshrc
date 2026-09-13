HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS

setopt NOBEEP
setopt NUMERIC_GLOB_SORT
setopt noflowcontrol

autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source ~/.aliases.zsh
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^[[1;5D" backward-word   # Ctrl+Left

bindkey "^[[1;3C" forward-word    # Alt+Right
bindkey "^[[1;3D" backward-word   # Alt+Left
