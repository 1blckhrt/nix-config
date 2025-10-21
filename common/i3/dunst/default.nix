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

        origin = "top-center"; # top-center
        width = "(200,300)";
        height = "(0,150)";
        frame_color = "#81A1C1"; # nord9 — blue accent

        # Make notifications grow downward
        horizontal_alignment = "center";
        vertical_alignment = "top";
      };

      urgency_low = {
        background = "#2E3440"; # nord0
        foreground = "#D8DEE9"; # nord4
        frame_color = "#4C566A"; # nord3
        timeout = 5;
      };

      urgency_normal = {
        background = "#3B4252"; # nord1
        foreground = "#ECEFF4"; # nord6
        frame_color = "#81A1C1"; # nord9
        timeout = 7;
      };

      urgency_critical = {
        background = "#BF616A"; # nord11
        foreground = "#ECEFF4"; # nord6
        frame_color = "#BF616A"; # nord11
        timeout = 0; # stays until dismissed
      };
    };
  };
}
