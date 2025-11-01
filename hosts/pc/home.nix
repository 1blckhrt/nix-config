{
  inputs,
  config,
  lib,
  pkgs,
  nixGL,
  nixvim,
  ...
}: {
  home.username = "blckhrt";
  home.homeDirectory = "/home/blckhrt";

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixGL = {
    packages = nixGL.packages;
    defaultWrapper = "mesa";
    installScripts = ["mesa"];
  };

  home.stateVersion = "25.05"; # DO NOT TOUCH

  imports = [
    nixvim.homeModules.nixvim
    ../../common/alacritty/default.nix
    ../../common/atuin/default.nix
    ../../common/bin/default.nix
    ../../common/i3/default.nix
    ../../common/hyprland/default.nix
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
    NIXOS_OZONE_WL = "1";
  };

  home.file.".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
    }
  '';

  programs.home-manager.enable = true;
}
