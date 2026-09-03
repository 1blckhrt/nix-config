{ pkgs, lib, ... }:
let
  colors = import ../../modules/colors.nix;
in
{
  imports = [
    ../../modules
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
      username = "blckhrt";
      homeDirectory = "/home/blckhrt";
      stateVersion = "25.11";
      sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.nix-profile/bin"
      ];
      packages = [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.fzf
      ];
    };

    targets.genericLinux = {
      enable = true;
      gpu.enable = true;
    };

    fonts.fontconfig.enable = true;
  };
}
