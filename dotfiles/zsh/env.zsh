eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval $(ssh-agent -s)

export EDITOR=nvim
export VISUAL=$EDITOR

export PATH=$HOME/.local/bin:$PATH

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
