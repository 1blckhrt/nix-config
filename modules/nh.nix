{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.nh;
  rebuildHomeScript = pkgs.writeShellScriptBin "switch" ''
    if [ -z "$1" ]; then
      echo "Error: Please specify a configuration name (e.g., laptop, pc)"
      exit 1
    fi

    cd /home/blckhrt/nix-config || exit
    git add .
    nh home switch /home/blckhrt/nix-config -c "$1"
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
      rebuildHomeScript
    ];
  };
}
