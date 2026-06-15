{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.tmux;
  tmuxPath = "${config.home.homeDirectory}/nix-config/modules/configs/tmux";
in
{
  options.modules.tmux = {
    enable = lib.mkEnableOption "Tmux";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
    ];

    home.file.".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink tmuxPath;
  };
}
