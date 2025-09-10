{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/Pictures/wallpapers/waves.jpg "];
      wallpaper = [", ~/Pictures/wallpapers/waves.jpg"];
    };
  };
}
