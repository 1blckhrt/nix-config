{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.alacritty;
in
{
  options.modules.alacritty = {
    enable = lib.mkEnableOption "alacritty";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          decorations = "Full";
          opacity = 0.95;
        };

        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          size = 16.0;
        };

        cursor = {
          style = {
            shape = "Beam";
            blinking = "Off";
          };
        };

        selection = {
          save_to_clipboard = true;
        };

        keyboard.bindings = [
          {
            key = "C";
            mods = "Control|Shift";
            action = "Copy";
          }
          {
            key = "V";
            mods = "Control";
            action = "Paste";
          }
          {
            key = "Equals";
            mods = "Control";
            action = "IncreaseFontSize";
          }
          {
            key = "Minus";
            mods = "Control";
            action = "DecreaseFontSize";
          }
        ];

        colors = {
          primary = {
            background = "#${config.theme.base00}";
            foreground = "#${config.theme.base05}";
          };

          cursor = {
            text = "#${config.theme.base00}";
            cursor = "#${config.theme.base05}";
          };

          selection = {
            text = "#${config.theme.base00}";
            background = "#${config.theme.base05}";
          };

          # Color 0-7
          normal = {
            black = "#${config.theme.base01}";
            red = "#${config.theme.base08}";
            green = "#${config.theme.base0B}";
            yellow = "#${config.theme.base0A}";
            blue = "#${config.theme.base0D}";
            magenta = "#${config.theme.base0E}";
            cyan = "#${config.theme.base0C}";
            white = "#${config.theme.base05}";
          };

          # Color 8-15
          bright = {
            black = "#${config.theme.base03}";
            red = "#${config.theme.base08}";
            green = "#${config.theme.base0B}";
            yellow = "#${config.theme.base09}";
            blue = "#${config.theme.base0D}";
            magenta = "#${config.theme.base0E}";
            cyan = "#${config.theme.base0C}";
            white = "#${config.theme.base07}";
          };
        };
      };
    };
  };
}
