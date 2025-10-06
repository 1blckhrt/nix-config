_: {
  programs.i3status = {
    enable = true;
    enableDefault = false;
    config = {
      general = {
        colors = true;
        color_good = "#A3BE8C"; # nord14 (green)
        color_degraded = "#EBCB8B"; # nord13 (yellow)
        color_bad = "#BF616A"; # nord11 (red)
        interval = 5;
      };

      order = [
        "wireless _first_"
        "battery 0"
        "tztime local"
      ];

      "wireless _first_" = {
        format_up = "  %quality %essid";
        format_down = "DOWN";
      };

      "battery 0" = {
        format = "⚡ %status %percentage";
        format_down = "No batt";
        integer_battery_capacity = true;
        last_full_capacity = true;
      };

      "tztime local" = {
        format = " %Y-%m-%d  %H:%M";
      };
    };
  };
}
