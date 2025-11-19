{
  config,
  pkgs,
  ...
}: {
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nix-config/common/tmux/conf/tmux.conf";

  home.packages = [
    pkgs.tmux
    pkgs.git
  ];
}
