hostname := `hostname`

# Clean nix garbage
clean:
  nix-collect-garbage -d

optimize:
	nix-store --optimise 

# Switch default shell to zsh
switch-shell:
  @echo "This will ask you for your sudo password. Afterwards, you will need to reboot to have the changes applied."
  echo "/home/blckhrt/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
  chsh --shell /home/blckhrt/.nix-profile/bin/zsh

# Create Hyprland wayland session desktop entry
create-hyprland-desktop:
  @echo "need to redo"
  
bootstrap-hm:
  @nix run home-manager/release-25.11 -- switch --flake ~/dot#{{hostname}}
