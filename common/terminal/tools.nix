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
    nodejs
    nix-prefetch-github
    npins
    pkgs-unstable.devenv
    keychain
    nil
    pkgs-unstable.zed-editor
    neovim
    opencode
  ];
}
