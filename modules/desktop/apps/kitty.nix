{
  lib,
  config,
  ...
}:

let
  cfg = config.modules.kitty;
in
{
  options.modules.kitty = {
    enable = lib.mkEnableOption "Terminal";
  };
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      settings = {
        cursor_text_color = "background";
        cursor_shape = "beam";
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
        "ctrl+equal" = "change_font_size all +1.0";
        "ctrl+minus" = "change_font_size all -1.0";
      };
    };
  };
}
