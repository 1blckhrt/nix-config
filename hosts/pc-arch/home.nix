{
  inputs,
  config,
  nixgl,
  lib,
  ...
}: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  home.username = "blckhrt";
  home.homeDirectory = "/home/blckhrt";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) ["nvidia"];
  };

  nixGL = {
    packages = nixgl;
    defaultWrapper = "nvidia";
  };

  home.stateVersion = "25.05"; # DO NOT TOUCH

  imports = [
    inputs.nixvim.homeModules.nixvim
    ../../common/alacritty/default.nix
    ../../common/atuin/default.nix
    ../../common/bin/default.nix
    ../../common/git/default.nix
    ../../common/misc/default.nix
    ../../common/nvim/default.nix
    ../../common/ssh/default.nix
    ../../common/starship/default.nix
    ../../common/tmux/default.nix
    ../../common/zoxide/default.nix
    ../../common/zsh/default.nix
  ];

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  home.file.".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  programs.home-manager.enable = true;
}
