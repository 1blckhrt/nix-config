{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.vicinae;
in
{
  options.modules.vicinae = {
    enable = lib.mkEnableOption "Vicinae";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
    ];
    programs.vicinae = {
      enable = true;
      settings = {
        pop_to_root_on_close = true;
        font.normal = {
          size = 14;
          family = "Iosevka Nerd Font";
        };
      };
      systemd = {
        enable = true;
        autoStart = true;
      };
    };
  };
}
