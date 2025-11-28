{config, ...}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    confPath = "${config.home.homeDirectory}/nix-config/common/temp-hypr/waybar/conf";
  in {
    "waybar".source = mkSymlink confPath;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
}
