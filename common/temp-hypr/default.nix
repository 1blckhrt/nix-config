{pkgs, ...}: {
  imports = [
    ./wm/default.nix
    ./fuzzel/default.nix
    ./swaybg/default.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    wallust
    swaybg
  ];
}
