{
  config,
  lib,
  pkgs,
  ...
}: {
  services.polybar = {
    enable = true;

    script = ''
      killall -q polybar
      while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
      polybar -c $HOME/.config/polybar/config
    '';

    settings = {
      "bar/top" = {
        width = "100%";
        height = "3%";
        "offset-x" = 0;
        "offset-y" = 0;
        radius = 0.0;
        "fixed-center" = true;

        modules-left = ["i3" "title" "mpd"];
        modules-center = ["date"];
        modules-right = ["pulseaudio" "network-short" "battery"];

        tray-position = "right";
      };

      "module/i3" = {
        "ws-icon-0" = "1;I";
        "ws-icon-1" = "2;II";
        "ws-icon-2" = "3;III";
        "ws-icon-3" = "4;IV";
        "ws-icon-4" = "5;V";
      };

      "module/network-short" = {
        type = "internal/network";
        interface = "wlan0";
      };

      "module/battery" = {
        type = "internal/battery";
        "battery-full-at" = 95;
        "battery-bat" = "BAT0";
        "battery-adp" = "AC";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        "master-soundcard" = "default";
        "speaker-soundcard" = "default";
        "headphone-soundcard" = "default";
        "master-mixer" = "Master";
      };

      "module/mpd" = {
        type = "internal/mpd";
        "mpd-host" = "127.0.0.1";
        "mpd-port" = 6600;
      };

      "module/i3" = {
        type = "internal/i3";
        show-urgent = true;
      };

      "module/title" = {
        type = "internal/xwindow";
      };
    };
  };
}
