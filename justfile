# List available commands
_default:
    @just --list

# Setup a system for the first time
bootstrap:
    nix run home-manager/release-26.05 -- switch --flake ~/nix-config#pc

# Commit changes
commit:
    convco commit

# Update Tack pins, rebuild, and rewrite the 'last-update' file.
update:
    nix run github:manic-systems/tack -- update
    nh home switch /home/blckhrt/nix-config -c pc
    mkdir -p ~/.local/state/nix-config
    date +%s > ~/.local/state/nix-config/last-update

# Start development shell
dev:
    nix develop

# Start Neovim development shell for configuration purposes
nvim-dev:
    nix shell .#homeConfigurations.pc.config.programs.mnw.finalPackage.devMode

# Switch default shell to ZSH. Requires sudo access
switch-shell:
    @echo "This will ask you for your sudo password. Afterwards, you will need to reboot to have the changes applied."
    @echo "/home/blckhrt/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
    @chsh --shell /home/blckhrt/.nix-profile/bin/zsh
