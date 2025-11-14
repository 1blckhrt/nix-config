{
  pkgs,
  config,
  ...
}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    confPath = "${config.home.homeDirectory}/nix-config/common/temp-hypr/conf";
  in {
    "hypr/configs".source = mkSymlink confPath;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      source = let
        configPath = "${config.home.homeDirectory}/.config/hypr/configs";
      in [
        "${configPath}/main.conf"
      ];
    };
  };
}
