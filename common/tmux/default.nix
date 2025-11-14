{
  config,
  pkgs,
  ...
}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    confPath = "${config.home.homeDirectory}/nix-config/common/tmux/conf";
  in {
    "tmux".source = mkSymlink confPath;
  };
  home.packages = [pkgs.tmux];
}
