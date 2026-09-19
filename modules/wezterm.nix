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
        local wezterm = require("wezterm")
        local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
        local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

        local config = {}

        config.default_workspace = "~"

        config.window_padding = {
          left = 4,
          right = 4,
          top = 4,
          bottom = 4,
        }
        config.window_background_opacity = 0.90

        config.window_close_confirmation = 'NeverPromptj

        config.font = wezterm.font("JetBrainsMono Nerd Font")
        config.font_size = 14.0

        config.default_cursor_style = "SteadyBar"

        config.keys = {
          { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
          { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },

          {
            key = "w",
            mods = "ALT",
            action = workspace_switcher.switch_workspace(),
          },

          {
            key = "d",
            mods = "ALT",
            action = wezterm.action_callback(function(win, pane)
              resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
                resurrect.state_manager.delete_state(id)
              end, {
                title = "Delete State",
                description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
                fuzzy_description = "Search State to Delete: ",
                is_fuzzy = true,
              })
            end),
          },

          -- resurrect.wezterm: save workspace state
          {
            key = "s",
            mods = "ALT",
            action = wezterm.action_callback(function(win, pane)
              resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
            end),
          },
        }

        config.colors = {
          foreground = "#${config.theme.base05}",
          background = "#${config.theme.base00}",

          cursor_bg = "#${config.theme.base05}",
          cursor_fg = "#${config.theme.base00}",
          cursor_border = "#${config.theme.base05}",

          selection_fg = "#${config.theme.base00}",
          selection_bg = "#${config.theme.base05}",

          ansi = {
            "#${config.theme.base01}",
            "#${config.theme.base08}",
            "#${config.theme.base0B}",
            "#${config.theme.base0A}",
            "#${config.theme.base0D}",
            "#${config.theme.base0E}",
            "#${config.theme.base0C}",
            "#${config.theme.base05}",
          },
          brights = {
            "#${config.theme.base03}",
            "#${config.theme.base08}",
            "#${config.theme.base0B}",
            "#${config.theme.base09}",
            "#${config.theme.base0D}",
            "#${config.theme.base0E}",
            "#${config.theme.base0C}",
            "#${config.theme.base07}",
          },

          tab_bar = {
            background = "#${config.theme.base00}",

            active_tab = {
              bg_color = "#${config.theme.base00}",
              fg_color = "#${config.theme.base0D}",
            },
            inactive_tab = {
              bg_color = "#${config.theme.base01}",
              fg_color = "#${config.theme.base04}",
            },
            new_tab = {
              bg_color = "#${config.theme.base01}",
              fg_color = "#${config.theme.base04}",
            },
            inactive_tab_hover = {
              bg_color = "#${config.theme.base05}",
              fg_color = "#${config.theme.base00}",
            },
            inactive_tab_edge = "#${config.theme.base05}",
          },
        }

        config.window_frame = {
          inactive_titlebar_bg = "#${config.theme.base00}",
          active_titlebar_bg = "#${config.theme.base00}",
          inactive_titlebar_fg = "#${config.theme.base05}",
          active_titlebar_fg = "#${config.theme.base05}",
        }

        config.command_palette_bg_color = "#${config.theme.base00}"
        config.command_palette_fg_color = "#${config.theme.base05}"
        config.char_select_bg_color = "#${config.theme.base00}"
        config.char_select_fg_color = "#${config.theme.base0D}"

        resurrect.state_manager.periodic_save({
          interval_seconds = 30,
          save_workspaces = true,
          save_windows = true,
          save_tabs = true,
        })

        local function basename(path)
          return string.gsub(path, "(.*[/\\])(.*)", "%2")
        end

        workspace_switcher.workspace_formatter = function(label)
          return wezterm.format({
            { Attribute = { Italic = true } },
            { Foreground = { Color = config.colors.ansi[3] } },
            { Background = { Color = config.colors.background } },
            { Text = "󱂬 : " .. label },
          })
        end

        wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
          window:gui_window():set_right_status(wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Foreground = { Color = config.colors.ansi[5] } },
            { Text = basename(path) .. "  " },
          }))
          local workspace_state = resurrect.workspace_state
          workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
            window = window,
            relative = true,
            restore_text = true,
            resize_window = false,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          })
        end)

        wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
          window:gui_window():set_right_status(wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Foreground = { Color = config.colors.ansi[5] } },
            { Text = basename(path) .. "  " },
          }))
        end)

        wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
          local workspace_state = resurrect.workspace_state
          resurrect.state_manager.save_state(workspace_state.get_workspace_state())
          resurrect.state_manager.write_current_state(label, "workspace")
        end)

        wezterm.on("smart_workspace_switcher.workspace_switcher.start", function(window, _) end)
        wezterm.on("smart_workspace_switcher.workspace_switcher.canceled", function(window, _) end)

        return config
      '';
    };
  };
}
