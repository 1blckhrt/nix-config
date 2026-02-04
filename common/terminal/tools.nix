{
  pkgs,
  inputs,
  ...
}: let
  myPkgs = import ../../pkgs/default.nix {inherit pkgs;};
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
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
    gum
    timewarrior
    nodejs
    nix-prefetch-github
    myPkgs.commit
    mypy
    pkgs-unstable.ty
  ];
}
