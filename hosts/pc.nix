{ pkgs, lib, ... }:
let
  colors = import ../modules/colors.nix;
in
{
  imports = [
    ../modules
  ];

  options.theme = lib.mkOption {
    type = lib.types.attrs;
    description = "The active Base16 theme palette";
  };

  config = {
    theme = colors.schemes.gruvbox-material-dark;
    modules = {
      nh.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      zsh.enable = true;
      alacritty.enable = true;
    };

    programs.home-manager.enable = true;

    home = {
      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.nix-profile/bin"
      ];
      packages = builtins.attrValues {
        inherit (pkgs) fzf;
        inherit (pkgs.nerd-fonts) jetbrains-mono;
      };
    };

    targets.genericLinux = {
      enable = true;
      gpu.nvidia = {
        enable = true;
        version = "595.99.02";
        sha256 = "sha256-6HR3lYv3YwcFSTJL1a1slI66btIQ5EAFs+/4SUD24ew=";
      };
    };

    fonts.fontconfig.enable = true;

    manual.manpages.enable = false;
  };
}
