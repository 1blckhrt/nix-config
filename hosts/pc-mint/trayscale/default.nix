{
  services.trayscale.enable = true;

  systemd.user.services.trayscale = {
    Unit = {
      After = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
    };
    Service = {
      Environment = [
        "DISPLAY=:0"
        "XDG_RUNTIME_DIR=%t"
      ];
    };
  };
}
