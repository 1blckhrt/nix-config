{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vicinae;
  vicinaePath = "${config.home.homeDirectory}/nix-config/dotfiles/vicinae/settings.json";
in
{
  options.modules.vicinae = {
    enable = lib.mkEnableOption "vicinae";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vicinae
    ];

    xdg.configFile."vicinae/settings.json".source = config.lib.file.mkOutOfStoreSymlink vicinaePath;
  };
}
