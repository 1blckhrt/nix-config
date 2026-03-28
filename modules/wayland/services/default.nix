_: {
  services = {
    swaync.enable = true;
    hyprpolkitagent.enable = true;
    cliphist.enable = true;
  };

  systemd.user.services.snixembed.Unit.After = [
    "graphical-session.target"
    "dbus.service"
  ];
}
