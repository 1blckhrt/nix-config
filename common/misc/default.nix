{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
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
    direnv
    zip
    unzip
    ntfy
    inputs.commit.packages.x86_64-linux.default
  ];

  fonts.fontconfig.enable = true;
}
