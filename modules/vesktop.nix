{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.vesktop;
  vesktopPath = "${config.home.homeDirectory}/nix-config/dotfiles/vesktop/settings.json";
in
{
  options.modules.vesktop = {
    enable = lib.mkEnableOption "Vesktop";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
    ];

    xdg.configFile."vesktop/settings.json".source = config.lib.file.mkOutOfStoreSymlink vesktopPath;
  };
}
