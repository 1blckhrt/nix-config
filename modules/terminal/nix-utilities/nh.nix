{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.nh;
  rebuildHomeScript = pkgs.writeShellScriptBin "switch" ''
    nh home switch /home/blckhrt/nix-config -c pc
  '';
in
{
  options.modules.nh = {
    enable = lib.mkEnableOption "NH - Yet another Nix helper";
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
      rebuildHomeScript
    ];
  };
}
