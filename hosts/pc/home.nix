{ pkgs, ... }:
{
  imports = [
    ../../modules
  ];

  modules = {
    nh.enable = true;
    neovim.enable = true;
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
    gpu.nvidia = {
      enable = true;
      version = "595.84";
      sha256 = "sha256-mcQE5SExvye8ptoCaNzOPr7cenOrF0BxqZXPGmxeugY=";
    };
  };

  fonts.fontconfig.enable = true;
}
