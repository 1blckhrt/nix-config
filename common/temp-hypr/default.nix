{pkgs, ...}: {
  imports = [
    ./wm/default.nix
    ./fuzzel/default.nix
    ./swaybg/default.nix
    ./waybar/default.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    wallust
    swaybg
    fuzzel
    brightnessctl
    swaynotificationcenter
    wlogout
  ];
}
