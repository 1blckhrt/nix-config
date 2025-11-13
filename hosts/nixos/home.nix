{...}: {
  home = {
    username = "blckhrt";
    homeDirectory = "/home/blckhrt";
    stateVersion = "25.05"; # DO NOT TOUCH
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      NIXOS_OZONE_WL = "1";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  imports = [
    ../../common/kitty/default.nix
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
    ../../common/temp-dir/default.nix
  ];

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland.enable = true;
}
