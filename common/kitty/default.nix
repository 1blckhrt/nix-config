{
  config,
  pkgs,
  ...
}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    confPath = "${config.home.homeDirectory}/nix-config/common/kitty/conf";
  in {
    "kitty".source = mkSymlink confPath;
  };
  home.packages = with pkgs; [
    kitty
  ];
}
