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
    nixd
    nixfmt
    direnv
    zip
    unzip
    ntfy
    inputs.commit.packages.x86_64-linux.default
    mpc
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "$HOME/Music/pi_music";
  };

  fonts.fontconfig.enable = true;
  xdg.enable = true;
}
