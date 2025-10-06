{
  pkgs,
  inputs,
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
    nil
    nixfmt
    direnv
    zip
    unzip
    ntfy
    inputs.commit.packages.x86_64-linux.default
  ];

  fonts.fontconfig.enable = true;
}
