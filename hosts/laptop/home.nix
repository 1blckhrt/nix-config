{
  pkgs,
  config,
  inputs,
  ...
}: let
  myPkgs = import ../../pkgs/default.nix {inherit pkgs;};
in {
  imports = [
    ../../common/desktop-apps/internet/vesktop.nix
    ../../common/terminal/default.nix
    ../../common/scripts/default.nix
    ../../common/wm/default.nix
    inputs.nix-colors.homeManagerModules.default
    inputs.nvf.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  modules = {
    discord.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  home = {
    username = "blckhrt";
    homeDirectory = "/home/blckhrt";
    stateVersion = "25.11";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      NIXOS_OZONE_WL = "1";
    };
    packages = with pkgs; [
      alejandra
    ];
    activation.linkDesktopApplications = {
      after = [
        "writeBoundary"
        "createXdgUserDirectories"
      ];
      before = [];
      data = ''
        rm -rf ${config.xdg.dataHome}/nix-desktop-files/applications
        mkdir -p ${config.xdg.dataHome}/nix-desktop-files/applications
        cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/nix-desktop-files/applications/
      '';
    };
  };

  programs.home-manager.enable = true;

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    systemDirs.data = ["${config.xdg.dataHome}/nix-desktop-files"];
    mime.enable = true;
  };
}
