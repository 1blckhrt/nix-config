{pkgs, ...}: {
  imports = [
    ./wm/default.nix
    ./fuzzel/default.nix
    ./hyprpaper/default.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    wallust
  ];
}
