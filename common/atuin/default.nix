{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };
}
