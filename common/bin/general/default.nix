{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./update-reminder.nix ./pacman-utils.nix];
}
