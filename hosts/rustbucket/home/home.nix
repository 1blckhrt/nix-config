{ lib, config, pkgs, inputs, ... }: {

  imports = [
    inputs.nixvim.homeModules.nixvim
    ../../../common/bin/default.nix
    ../../../common/nvim/default.nix
    ../../../common/starship/default.nix
    ../../../common/zoxide/default.nix
    ../../../common/atuin/default.nix
    ../../../common/git/default.nix
    ../../../common/misc/default.nix
    ../../../common/ssh/default.nix
    ../../../common/tmux/default.nix
    ../../../common/zsh/default.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}

