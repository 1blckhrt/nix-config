_: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };

      colors = {
        # Nord theme
        primary = {
          background = "#2E3440"; # nord0
          foreground = "#D8DEE9"; # nord4
        };

        cursor = {
          text = "#2E3440"; # nord0
          cursor = "#D8DEE9"; # nord4
        };

        normal = {
          black = "#3B4252"; # nord1
          red = "#BF616A"; # nord11
          green = "#A3BE8C"; # nord14
          yellow = "#EBCB8B"; # nord13
          blue = "#81A1C1"; # nord9
          magenta = "#B48EAD"; # nord15
          cyan = "#88C0D0"; # nord8
          white = "#E5E9F0"; # nord5
        };

        bright = {
          black = "#4C566A"; # nord3
          red = "#BF616A"; # nord11
          green = "#A3BE8C"; # nord14
          yellow = "#EBCB8B"; # nord13
          blue = "#81A1C1"; # nord9
          magenta = "#B48EAD"; # nord15
          cyan = "#8FBCBB"; # nord7
          white = "#ECEFF4"; # nord6
        };
      };

      font = {
        size = 10.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };
    };
  };
}
