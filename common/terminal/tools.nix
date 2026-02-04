{pkgs, ...}: let
  myPkgs = import ../../pkgs/default.nix {inherit pkgs;};
in {
  home.packages = with pkgs; [
    coreutils
    moreutils
    eza
    ripgrep
    fzf
    fd
    bat
    zoxide
    btop
    fastfetch
    gh
    gcc
    zip
    unzip
    just
    wget
    curl
    atuin
    devenv
    uv
    neovim
    gum
    timewarrior
    nodejs
    nix-prefetch-github
    myPkgs.commit
    mypy
    ruff
    ty
  ];
}
