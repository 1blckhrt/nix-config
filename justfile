# List available commands
_default:
  @just --list

# Update all flake inputs
update:
  @nix flake update

# Collect garbage
clean:
  @nix-collect-garbage -d

# Optimize the Nix store
optimize:
  @nix-store --optimise

# Switch default shell to zsh
switch-shell:
  @echo "This will ask you for your sudo password. Afterwards, you will need to reboot to have the changes applied."
  @echo "/home/blckhrt/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
  @chsh --shell /home/blckhrt/.nix-profile/bin/zsh
