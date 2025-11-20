{pkgs, ...}: let
  myPkgs = import ../../pkgs/default.nix {inherit pkgs;};
in {
  home.packages = with pkgs; [
    coreutils
    python3
    mosh
    fzf
    fd
    ripgrep
    bat
    lsd
    zoxide
    btop
    fastfetch
    gh
    gcc
    uv
    alejandra
    nil
    nixd
    nixfmt
    zip
    unzip
    mpc
    just
    devenv
    statix
    myPkgs.commit
  ];

  fonts.fontconfig.enable = true;
  xdg = {
    enable = true;
    mime.enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    silent = true;
    nix-direnv.enable = true;
  };
}
