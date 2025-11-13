{
  config,
  pkgs,
  ...
}: let
  hyprlandPath = "${config.home.homeDirectory}/nix-config/common/temp-dir";
in {
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprlandPath;
}
