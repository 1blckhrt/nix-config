{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.kitty;
  kittyPath = "${config.home.homeDirectory}/nix-config/dotfiles/kitty/kitty.conf";
in
{
  options.modules.kitty = {
    enable = lib.mkEnableOption "kitty";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kitty
    ];

    xdg.configFile."kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink kittyPath;
  };
}
