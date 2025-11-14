{config, ...}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    confPath = "${config.home.homeDirectory}/nix-config/common/temp-hypr/hyprpaper/conf";
  in {
    "hypr/configs".source = mkSymlink confPath;
  };

  services.hyprpaper.enable = true;
}
