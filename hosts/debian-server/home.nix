{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../common/terminal/default.nix
    ../../common/scripts/default.nix
    inputs.nixvim.homeModules.nixvim
  ];

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
    };
    packages = with pkgs; [
      alejandra
      nil
    ];
  };

  programs.home-manager.enable = true;

  targets.genericLinux = {
    enable = true;
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    mime.enable = true;
  };
}
