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
    theme = colors.schemes.github-dark;
    modules = {
      nh.enable = true;
      neovim.enable = true;
      tmux.enable = true;
      zsh.enable = true;
      alacritty.enable = true;
      sway.enable = true;
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
      packages = builtins.attrValues {
        inherit (pkgs) fzf;
        inherit (pkgs.nerd-fonts) jetbrains-mono;
      };
    };

    targets.genericLinux = {
      enable = true;
      gpu.nvidia = {
        enable = true;
        version = "595.84";
        sha256 = "sha256-mcQE5SExvye8ptoCaNzOPr7cenOrF0BxqZXPGmxeugY=";
      };
    };

    fonts.fontconfig.enable = true;
  };
}
