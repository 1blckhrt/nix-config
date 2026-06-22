{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.modules.oxwm;
  oxwmPath = "${config.home.homeDirectory}/nix-config/modules/configs/oxwm/config.lua";
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{
  options.modules.oxwm = {
    enable = lib.mkEnableOption "OXWM";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs-unstable; [
      oxwm
      picom
      dunst
      xdotool
      xclip
      feh
      maim
    ];

    xdg.configFile."oxwm/config.lua".source = config.lib.file.mkOutOfStoreSymlink oxwmPath;
  };
}
