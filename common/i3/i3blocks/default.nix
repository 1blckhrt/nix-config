{
  config,
  pkgs,
  lib,
  ...
}: {
  home.file.".config/i3blocks/config".source = ./i3blocks.conf;

  home.packages = with pkgs; [
    pulsemixer
    xdotool
    pavucontrol
  ];
}
