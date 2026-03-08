hostname := `hostname`

update:
  @nix flake update

clean:
  @nix-collect-garbage -d

optimize:
  @nix-store --optimise

# Switch default shell to zsh
switch-shell:
  @echo "This will ask you for your sudo password. Afterwards, you will need to reboot to have the changes applied."
  @echo "/home/blckhrt/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
  @chsh --shell /home/blckhrt/.nix-profile/bin/zsh

install-hyprland-session:
    printf '[Desktop Entry]\nName=Hyprland (Nix)\nComment=Hyprland Wayland session\nExec=hyprland\nType=Application\n' | sudo tee /usr/share/wayland-sessions/hyprland.desktop

bootstrap-hm:
  @nix run home-manager/release-25.11 -- switch --flake ~/nix-config#{{hostname}}
