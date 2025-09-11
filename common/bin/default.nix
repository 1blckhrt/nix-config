{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./dev/default.nix ./notes/default.nix ./notes-site/default.nix];
}
