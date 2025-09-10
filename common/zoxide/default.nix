{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
