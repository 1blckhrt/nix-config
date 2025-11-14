{config, ...}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    confPath = "${config.home.homeDirectory}/nix-config/common/temp-hypr/fuzzel/conf";
  in {
    "fuzzel".source = mkSymlink confPath;
  };

  programs.fuzzel.enable = true;
}
