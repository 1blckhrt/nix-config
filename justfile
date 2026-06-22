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

install-oxwm-session:
  printf '[Desktop Entry]\nName=OXWM (Nix)\nComment=OXWM X11 session\nExec=/home/blckhrt/.nix-profile/bin/oxwm\nType=Application\n' | sudo tee /usr/share/xsessions/oxwm.desktop
