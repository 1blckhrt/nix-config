{pkgs, ...}: {
  programs.autorandr.enable = true;

  programs.autorandr.profiles = {
    "default" = {
      config = {
        eDP1.enable = true;
      };
    };
    "dual" = {
      config = {
        eDP-1.enable = true;
        HDMI-1.enable = true;
        HDMI-1.mode = "1920x1080";
        HDMI-1.position = "1920x0";
        eDP-1.primary = true;
      };
    };
  };

  programs.autorandr.hooks = {
    preswitch = {
      "notify-send" = ''
        notify-send "Changing monitor layout in 5 seconds..."
      '';
      "sleep" = "sleep 5";
    };
    postswitch = {
      "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
      "notify-send" = ''
        notify-send "Monitor layout changed"
      '';
    };
  };
}
