{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.nh;
  rebuildHomeScriptLaptop = pkgs.writeShellScriptBin "switch-laptop" ''
    cd /home/blckhrt/nix-config || exit
    git add .
    nh home switch /home/blckhrt/nix-config -c laptop
  '';
  rebuildHomeScriptPC = pkgs.writeShellScriptBin "switch-pc" ''
    cd /home/blckhrt/nix-config || exit
    git add .
    nh home switch /home/blckhrt/nix-config -c pc
  '';
in
{
  options.modules.nh = {
    enable = lib.mkEnableOption "nh";
  };
  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      homeFlake = "/home/blckhrt/nix-config/";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };

    home.packages = [
      rebuildHomeScriptLaptop
      rebuildHomeScriptPC
    ];
  };
}
