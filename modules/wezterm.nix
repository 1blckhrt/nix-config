{
  config,
  lib,
  ...
}:

let
  cfg = config.modules.wezterm;
in
{
  options.modules.wezterm = {
    enable = lib.mkEnableOption "wezterm";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;

      extraConfig = ''
        local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")

        sessions.apply_to_config(config, {
          auto_save_interval_s = 30,
          git_branch_warn = true,
          save_state_dir = "default-user-owned",
        })
      '';

      settings = {
        font = lib.generators.mkLuaInline ''wezterm.font("JetBrainsMono Nerd Font")'';
        font_size = 16.0;

        default_cursor_style = "SteadyBar";

        window_padding = {
          left = 10;
          right = 10;
          top = 10;
          bottom = 10;
        };

        window_decorations = "RESIZE";
        window_background_opacity = 0.95;

        keys = [
          {
            key = "d";
            mods = "ALT|SHIFT";
            action = lib.generators.mkLuaInline ''wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }'';
          }
          {
            key = "V";
            mods = "ALT|SHIFT";
            action = lib.generators.mkLuaInline ''wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }'';
          }
          {
            key = "LeftArrow";
            mods = "ALT";
            action = lib.generators.mkLuaInline ''wezterm.action.ActivatePaneDirection("Left")'';
          }
          {
            key = "RightArrow";
            mods = "ALT";
            action = lib.generators.mkLuaInline ''wezterm.action.ActivatePaneDirection("Right")'';
          }
          {
            key = "UpArrow";
            mods = "ALT";
            action = lib.generators.mkLuaInline ''wezterm.action.ActivatePaneDirection("Up")'';
          }
          {
            key = "DownArrow";
            mods = "ALT";
            action = lib.generators.mkLuaInline ''wezterm.action.ActivatePaneDirection("Down")'';
          }
          {
            key = "c";
            mods = "CTRL|SHIFT";
            action = lib.generators.mkLuaInline ''wezterm.action.CopyTo("Clipboard")'';
          }
          {
            key = "v";
            mods = "CTRL";
            action = lib.generators.mkLuaInline ''wezterm.action.PasteFrom("Clipboard")'';
          }
          {
            key = "=";
            mods = "CTRL";
            action = lib.generators.mkLuaInline "wezterm.action.IncreaseFontSize";
          }
          {
            key = "-";
            mods = "CTRL";
            action = lib.generators.mkLuaInline "wezterm.action.DecreaseFontSize";
          }
          # Rename current workspace
          {
            key = "r";
            mods = "CTRL|SHIFT";
            action = lib.generators.mkLuaInline ''
              wezterm.action.PromptInputLine {
                description = 'Enter new workspace name',
                action = wezterm.action_callback(
                  function(window, pane, line)
                    if line then
                      wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
                    end
                  end
                ),
              }
            '';
          }
          # Prompt for a name to use for a new workspace and switch to it
          {
            key = "w";
            mods = "CTRL|SHIFT";
            action = lib.generators.mkLuaInline ''
              wezterm.action.PromptInputLine {
                description = wezterm.format {
                  { Attribute = { Intensity = 'Bold' } },
                  { Foreground = { AnsiColor = 'Fuchsia' } },
                  { Text = 'Enter name for new workspace' },
                },
                action = wezterm.action_callback(
                  function(window, pane, line)
                    if line then
                      window:perform_action(
                        wezterm.action.SwitchToWorkspace {
                          name = line,
                        },
                        pane
                      )
                    end
                  end
                ),
              }
            '';
          }
        ];

        colors = {
          background = "#${config.theme.base00}";
          foreground = "#${config.theme.base05}";

          cursor_bg = "#${config.theme.base05}";
          cursor_fg = "#${config.theme.base00}";

          selection_bg = "#${config.theme.base05}";
          selection_fg = "#${config.theme.base00}";

          # 8-color palette (Color 0 - 7)
          ansi = [
            "#${config.theme.base01}" # Black
            "#${config.theme.base08}" # Red
            "#${config.theme.base0B}" # Green
            "#${config.theme.base0A}" # Yellow
            "#${config.theme.base0D}" # Blue
            "#${config.theme.base0E}" # Magenta
            "#${config.theme.base0C}" # Cyan
            "#${config.theme.base05}" # White
          ];

          # Bright 8-color palette (Color 8 - 15)
          brights = [
            "#${config.theme.base03}" # Bright Black
            "#${config.theme.base08}" # Bright Red
            "#${config.theme.base0B}" # Bright Green
            "#${config.theme.base09}" # Bright Yellow
            "#${config.theme.base0D}" # Bright Blue
            "#${config.theme.base0E}" # Bright Magenta
            "#${config.theme.base0C}" # Bright Cyan
            "#${config.theme.base07}" # Bright White
          ];

          tab_bar = {
            background = "#${config.theme.base00}";

            active_tab = {
              bg_color = "#${config.theme.base00}";
              fg_color = "#${config.theme.base05}";
            };

            inactive_tab = {
              bg_color = "#${config.theme.base00}";
              fg_color = "#${config.theme.base03}";
            };
          };
        };
      };
    };
  };
}
