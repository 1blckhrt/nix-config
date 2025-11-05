{
  pkgs,
  commit,
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
    nixd
    nixfmt
    direnv
    zip
    unzip
    ntfy
    commit.packages.x86_64-linux.default
    mpc
    just
    devenv
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "$HOME/Music/pi_music";
  };

  fonts.fontconfig.enable = true;
  xdg.enable = true;
  xdg.mime.enable = true;
}
