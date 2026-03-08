{config, ...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12.0;
    };

    settings = with config.colorScheme.palette; {
      foreground = "#${base05}";
      background = "#${base00}";
      cursor = "#${base0D}";
      cursor_text_color = "background";
      cursor_shape = "beam";

      # black
      color0 = "#${base01}";
      color8 = "#${base03}";
      # red
      color1 = "#${base08}";
      color9 = "#${base08}";
      # green
      color2 = "#${base0B}";
      color10 = "#${base0B}";
      # yellow
      color3 = "#${base0A}";
      color11 = "#${base0A}";
      # blue
      color4 = "#${base0D}";
      color12 = "#${base0D}";
      # magenta
      color5 = "#${base0E}";
      color13 = "#${base0E}";
      # cyan
      color6 = "#${base0C}";
      color14 = "#${base07}";
      # white
      color7 = "#${base05}";
      color15 = "#${base06}";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      background_opacity = "0.8";
      background_blur = 5;
      url_style = "curly";
      open_url_with = "default";
      copy_on_select = true;
      window_padding_width = 10;
      hide_window_decorations = true;
      confirm_os_window_close = 0;
      cursor_trail = 1;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+equal" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
    };
  };
}
