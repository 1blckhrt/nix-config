{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.nh;
  rebuildHomeScript = pkgs.writeShellScriptBin "switch" ''
    cd /home/blckhrt/nix-config || exit
    git add .
    nh home switch /home/blckhrt/nix-config -c laptop
  '';
  updateScript = pkgs.writeShellScriptBin "update" ''
    cd /home/blckhrt/nix-config || exit
    git add .
    nh home switch /home/blckhrt/nix-config -u -c laptop && git commit -am "chore: update flake" && git push
  '';
in
{
  options.modules.nh = {
    enable = lib.mkEnableOption "NH";
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
      updateScript
    ];
  };
}
