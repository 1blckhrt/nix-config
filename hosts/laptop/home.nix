{ pkgs, ... }:
{
  imports = [
    ../../modules
  ];

  modules = {
    kitty.enable = true;
    nh.enable = true;
    neovim.enable = true;
    vicinae.enable = true;
    tmux.enable = true;
    zsh.enable = true;
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
      pkgs.nerd-fonts.iosevka
    ];
  };

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  fonts.fontconfig.enable = true;
}
