{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.program;
  programPath = "${config.home.homeDirectory}/nix-config/dotfiles/program/program.conf";
in
{
  options.modules.tmux = {
    enable = lib.mkEnableOption "Program";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      program
    ];

    home.file."program.conf".source = config.lib.file.mkOutOfStoreSymlink tmuxPath;
  };
}
