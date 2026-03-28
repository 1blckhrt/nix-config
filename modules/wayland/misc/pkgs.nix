{pkgs, ...}: {
  home.packages = with pkgs; [
    brightnessctl
    grim
    wl-clipboard
    slurp
    snixembed
    networkmanagerapplet
    libappindicator-gtk3
    swaynotificationcenter
    cliphist
    pulseaudio
    libnotify
    pango
    playerctl
    nautilus
    hyprpolkitagent
    font-awesome
    nerd-fonts.jetbrains-mono
    pavucontrol
    flameshot
    nwg-displays
    nwg-look
  ];
}
