eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval $(ssh-agent -s)

export EDITOR=nvim
export VISUAL=$EDITOR

export PATH=$HOME/.local/bin:$PATH

export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH=/home/blckhrt/.opencode/bin:$PATH

# pnpm
export PNPM_HOME="/home/blckhrt/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
