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
      alacritty.enable = true;
      neovim.enable = true;
      nh.enable = true;
      tmux.enable = true;
      zsh.enable = true;
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
      gpu.enable = true;
    };

    fonts.fontconfig.enable = true;

    manual.manpages.enable = false;
  };
}
