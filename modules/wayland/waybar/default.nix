_: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    style = ./style.css;

    settings = [
      {
        layer = "top";
        height = 28;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = ["clock"];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
          "tray"
        ];

        "hyprland/window" = {
          max-length = 30;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        clock = {
          interval = 30;
          format = "{:%I:%M %p}";
          tooltip-format = "{:%a, %d %b %G}";
        };

        tray = {
          icon-size = 20;
          spacing = 8;
        };

        pulseaudio = {
          format-source = "󰍬";
          format-source-muted = "󰍭";
          format = "{format_source} 󰕾 {volume}%";
          format-bluetooth = "{format_source} 󰂰 {volume}%";
          format-muted = "{format_source} 󰸈";
          max-volume = 150;
          scroll-step = 1;
        };

        bluetooth = {
          format = "";
          format-disabled = "";
          format-off = "";
          format-on = "󰂯";
          format-connected = "󰂱 {device_alias}";
          max-length = 16;
        };

        network = {
          format = "{ifname}";
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = "Disconnected";
          max-length = 32;
        };

        battery = {
          interval = 60;
          format-time = "{H}:{m}";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-discharging = "{icon} {capacity}% ({time})";
          format-charging = "󰂄 {capacity}%";
          format = "";
        };
      }
    ];
  };
}
