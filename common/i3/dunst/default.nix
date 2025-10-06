_: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        transparency = 0;
        frame_width = 2;
        separator_height = 2;
        padding = 8;
        default_timeout = 7;
        max_icon_size = 32;
        monitor = "primary";
        startup_notification = false;
        font = "JetBrainsMono Nerd Font 12";
        format = "<b>%s</b>\n%s";
        sort = true;
        indicateHidden = true;
        stackDuplicates = true;
        hideDuplicateCount = true;
        showAgeThreshold = 60;
        origin = "top-right";
        width = 300;
        height = 80;
        frame_color = "#81A1C1"; # nord9 — blue accent
      };

      urgency_low = {
        background = "#2E3440"; # nord0 — dark base
        foreground = "#D8DEE9"; # nord4 — light text
        frame_color = "#4C566A"; # nord3 — subtle border
        timeout = 5;
      };

      urgency_normal = {
        background = "#3B4252"; # nord1
        foreground = "#ECEFF4"; # nord6
        frame_color = "#81A1C1"; # nord9
        timeout = 7;
      };

      urgency_critical = {
        background = "#BF616A"; # nord11 — red alert
        foreground = "#ECEFF4"; # nord6 — bright text
        frame_color = "#BF616A"; # nord11
        timeout = 0; # stays until dismissed
      };
    };
  };
}
