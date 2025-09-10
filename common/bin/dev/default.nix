{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./tmux-sessionizer.nix ./cheat-sheet.nix];
}
