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
      image = ./themes/gruvbox-material/wallpaper.png;
      enable = true;
      autoEnable = true;
      base16Scheme = ./themes/gruvbox-material/colors.yaml;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.iosevka;
          name = "Iosevka Nerd Font";
        };
        serif = {
          package = pkgs.nerd-fonts.iosevka;
          name = "Iosevka Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.iosevka;
          name = "Iosevka Nerd Font";
        };
      };
    };
  };
}
