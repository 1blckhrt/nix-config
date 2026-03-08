{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.discord;
in {
  options.modules.discord = {
    enable = mkEnableOption "Discord (Vesktop client)";
  };

  config = mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        arRPC = true;
        checkUpdates = false;
        hardwareAcceleration = true;
      };
    };

    services.arrpc.enable = true;
  };
}
