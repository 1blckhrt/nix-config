{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.stylix;
in
{
  options.modules.stylix = {
    enable = lib.mkEnableOption "Stylix";
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = ./themes/gruvbox-material-dark-hard.yaml;
      fonts = {
        monospace = {
          package = pkgs.ioskeley-mono.normal-NF;
          name = "IoskeleyMono Nerd Font";
        };
        serif = {
          package = pkgs.ioskeley-mono.normal-NF;
          name = "IoskeleyMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.ioskeley-mono.normal-NF;
          name = "IoskeleyMono Nerd Font";
        };
      };
    };
  };
}
