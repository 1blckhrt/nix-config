{
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in {
  xdg.configFile."zed/settings.json".source = ./settings.json;
  xdg.configFile."zed/nordic.json".source = ./nordic.json;

  home.packages = [
    pkgs-unstable.zed-editor
  ];
}
