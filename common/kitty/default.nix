{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;

    package = config.lib.nixGL.wrap pkgs.kitty;

    settings = {
      # Font
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "JetBrainsMono Nerd Font Bold";
      italic_font = "JetBrainsMono Nerd Font Italic";
      bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";
      font_size = 10.0;

      # Window padding
      window_padding_width = 10;

      background_opacity = "0.90";

      # Nord theme colors
      background = "#2E3440";
      foreground = "#D8DEE9";
      cursor = "#D8DEE9";
      cursor_text_color = "#2E3440";
      selection_foreground = "none";
      selection_background = "#4C566A";

      # Normal colors
      color0 = "#3B4252";
      color1 = "#BF616A";
      color2 = "#A3BE8C";
      color3 = "#EBCB8B";
      color4 = "#81A1C1";
      color5 = "#B48EAD";
      color6 = "#88C0D0";
      color7 = "#E5E9F0";

      # Bright colors
      color8 = "#4C566A";
      color9 = "#BF616A";
      color10 = "#A3BE8C";
      color11 = "#EBCB8B";
      color12 = "#81A1C1";
      color13 = "#B48EAD";
      color14 = "#8FBCBB";
      color15 = "#ECEFF4";

      # Misc
      confirm_os_window_close = "0";
      enable_audio_bell = "no";
    };
  };
}
