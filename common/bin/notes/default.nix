{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./new-note.nix ./note-commit.nix];
}
