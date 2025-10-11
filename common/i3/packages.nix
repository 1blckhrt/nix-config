{pkgs, ...}: {
  home.packages = with pkgs; [
    pulseaudio
    dex
    xss-lock
    i3lock
    networkmanagerapplet
    libnotify
    libappindicator-gtk3
    libayatana-appindicator
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    python313Packages.i3ipc
    snixembed
    font-awesome
    pavucontrol
    playerctl
    nerd-fonts.jetbrains-mono
    autotiling
    flameshot
    feh
    pulsemixer
    coreutils
    gawk
    i3blocks
  ];

  services.flameshot.enable = true;
}
