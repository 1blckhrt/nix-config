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
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };
    };
  };
}
