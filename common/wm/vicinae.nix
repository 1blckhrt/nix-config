{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  xdg.configFile."vicinae/vicinae.json".source = ./vicinae.json;

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
      nix
      power-profile
      github
      chromium-bookmarks
      (config.lib.vicinae.mkRayCastExtension {
        name = "obsidian";
        sha256 = "sha256-nNfL56k17o1dPMT8PQqrgNjUf6rxLhHzhrvHdxrdFsQ=";
        rev = "dd868b050e615d5a48612e6a24da75069cd04028";
      })
    ];
  };
}
