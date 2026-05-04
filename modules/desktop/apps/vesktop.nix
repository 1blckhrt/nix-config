{
  lib,
  config,
  ...
}:

let
  cfg = config.modules.vesktop;
in
{
  options.modules.vesktop = {
    enable = lib.mkEnableOption "Third party Discord client optimized for Linux";
  };
  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        arRPC = true;
        checkUpdates = false;
        hardwareAcceleration = true;
        minimizeToTray = true;
      };
    };
    services.arrpc.enable = true;
  };
}
