{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./dev/default.nix ./notes/default.nix ./general/default.nix];
}
