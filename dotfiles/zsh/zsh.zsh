source_if_exists() {
	if test -r "$1"; then
		source "$1"
	fi
}

source_if_exists ~/dot/dotfiles/zsh/history.zsh
source_if_exists ~/dot/dotfiles/zsh/aliases.zsh
source_if_exists ~/dot/dotfiles/zsh/alias-functions.zsh
source_if_exists ~/dot/dotfiles/zsh/env.zsh

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

precmd() {
	source ~/dot/dotfiles/zsh/aliases.zsh
	source ~/dot/dotfiles/zsh/alias-functions.zsh
}

bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^[[1;5D" backward-word   # Ctrl+Left

bindkey "^[[1;3C" forward-word    # Alt+Right
bindkey "^[[1;3D" backward-word   # Alt+Left

clear
