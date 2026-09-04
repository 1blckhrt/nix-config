{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.sway;
  theme = config.theme;
in
{
  options.modules.sway = {
    enable = lib.mkEnableOption "sway";
  };
  config = lib.mkIf cfg.enable {
    services = {
      avizo.enable = true;
      cliphist = {
        enable = true;
        allowImages = true;
        systemdTargets = [ "sway-session.target" ];
      };
      swaync.enable = true;
      flameshot = {
        enable = true;
        settings = {
          General = {
            useGrimAdapter = true;
          };
        };
      };
      autotiling = {
        enable = true;
        systemdTarget = "sway-session.target";
      };
    };
    xdg.configFile."background".source = theme.wallpaper;
    programs = {
      i3status-rust = {
        enable = true;
        bars.default = {
          settings.theme.overrides.separator = "";
          blocks = [
            {
              block = "time";
              interval = 5;
              format = "   $timestamp.datetime(f:'%a %b %d %I:%M %p') ";
            }
          ];
        };
      };
      fuzzel = {
        enable = true;
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=12";
            terminal = "kitty";
            prompt = "> ";
            layer = "overlay";
            lines = 10;
            width = 45;
          };
          colors = {
            background = "${theme.base00}ff";
            text = "${theme.base05}ff";
            match = "${theme.base0C}ff";
            selection = "${theme.base01}ff";
            selection-text = "${theme.base07}ff";
            border = "${theme.base0D}ff";
          };
          border = {
            width = 2;
            radius = 8;
          };
        };
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
      systemd.enable = true;
      wrapperFeatures.gtk = true;
      extraOptions = [
        "--unsupported-gpu"
      ];
      checkConfig = false;
      config = {
        modifier = "Mod4";
        focus.followMouse = true;
        fonts = {
          names = [
            "JetBrainsMono Nerd Font"
          ];
          size = "12";
        };
        output."*".bg = "${theme.wallpaper} fill";
        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";
            fonts = {
              names = [ "JetBrainsMono Nerd Font" ];
              size = 12.0;
            };
            colors = {
              background = theme.base00;
              statusline = theme.base05;
              focusedWorkspace = {
                border = theme.base0B;
                background = theme.base0B;
                text = theme.base00;
              };
              activeWorkspace = {
                border = theme.base03;
                background = theme.base01;
                text = theme.base05;
              };
              inactiveWorkspace = {
                border = theme.base00;
                background = theme.base00;
                text = theme.base03;
              };
              urgentWorkspace = {
                border = theme.base08;
                background = theme.base08;
                text = theme.base00;
              };
            };
          }
        ];
        gaps = {
          smartBorders = "on";
          smartGaps = "on";
          top = 4;
          right = 4;
          bottom = 4;
          left = 4;
          inner = 4;
        };
        window = {
          titlebar = false;
          border = 2;
        };
        startup = [
          { command = "systemctl --user start cliphist"; }
          { command = "systemctl --user start swaync"; }
          {
            command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_DATA_DIRS";
          }
          { command = "nm-applet --indicator"; }
          { command = "avizo-service"; }
        ];
        input = {
          "type:keyboard" = {
            "repeat_delay" = "250";
            "repeat_rate" = "30";
          };
        };
        keybindings = lib.mkOptionDefault {
          "Mod4+d" = "exec fuzzel";
          "Mod4+Return" = "exec alacritty";

          "XF86AudioRaiseVolume" = "exec ${pkgs.avizo}/bin/volumectl -u up";
          "XF86AudioLowerVolume" = "exec ${pkgs.avizo}/bin/volumectl -u down";
          "XF86AudioMute" = "exec ${pkgs.avizo}/bin/volumectl toggle-mute";
          "XF86AudioMicMute" = "exec ${pkgs.avizo}/bin/volumectl -m toggle-mute";
          "XF86MonBrightnessUp" = "exec ${pkgs.avizo}/bin/lightctl up";
          "XF86MonBrightnessDown" = "exec ${pkgs.avizo}/bin/lightctl down";

          "Mod4+1" = "workspace number 1";
          "Mod4+2" = "workspace number 2";
          "Mod4+3" = "workspace number 3";
          "Mod4+4" = "workspace number 4";

          "Mod4+Down" = "focus down";
          "Mod4+Left" = "focus left";
          "Mod4+Right" = "focus right";
          "Mod4+Up" = "focus up";

          "Mod4+Shift+1" = "move container to workspace number 1";
          "Mod4+Shift+2" = "move container to workspace number 2";
          "Mod4+Shift+3" = "move container to workspace number 3";
          "Mod4+Shift+4" = "move container to workspace number 4";

          "Mod4+Shift+r" = "reload";
          "Mod4+Shift+e" = "exec 'swaymsg exit'";
          "Mod4+q" = "kill";

          "Mod4+f" = "fullscreen toggle";
        };
      };
    };
  };
}
