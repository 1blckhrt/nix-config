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
  @echo "Creating Hyprland desktop entry (requires sudo)"
  echo '[Desktop Entry]\nName=Hyprland\nComment=An intelligent dynamic tiling Wayland compositor\nExec=/home/blckhrt/.nix-profile/bin/Hyprland\nType=Application' | sudo tee /usr/share/wayland-sessions/hyprland.desktop
