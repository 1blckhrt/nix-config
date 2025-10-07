{
  config,
  pkgs,
  ...
}: let
  mod = config.xsession.windowManager.i3.config.modifier;
in {
  imports = [./dunst/default.nix ./polybar/default.nix ./rofi/default.nix ./picom/default.nix ./packages.nix ./monitors.nix];
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";

        fonts = {
          names = ["JetBrainsMono NF"];
          size = 12.0;
        };

        keybindings = {
          "${mod}+Return" = "exec --no-startup-id ${pkgs.alacritty}/bin/alacritty";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "exec i3-msg restart; notify-send 'i3 has been refreshed.'";
          "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit' 'i3-msg exit'";

          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          "Print" = "exec flameshot";

          "${mod}+Tab" = "workspace next";
          "${mod}+Shift+Tab" = "workspace prev";
        };

        window = {
          border = 5;
          commands = [
            {
              command = "border pixel 5";
              criteria = {class = "^.*";};
            }
          ];
        };

        floating = {modifier = "Mod4";};

        gaps = {
          inner = 12;
          smartGaps = true;
        };

        colors = {
          # Nord palette reference:
          # nord0: #2E3440 (background)
          # nord1: #3B4252
          # nord2: #434C5E
          # nord3: #4C566A
          # nord4: #D8DEE9 (text)
          # nord5: #E5E9F0
          # nord6: #ECEFF4
          # nord7: #8FBCBB
          # nord8: #88C0D0
          # nord9: #81A1C1
          # nord10: #5E81AC
          # nord11: #BF616A
          # nord12: #D08770
          # nord13: #EBCB8B
          # nord14: #A3BE8C
          # nord15: #B48EAD

          focused = {
            border = "#81A1C1"; # nord9
            background = "#3B4252"; # nord1
            text = "#ECEFF4"; # nord6
            indicator = "#88C0D0"; # nord8
            childBorder = "#81A1C1"; # nord9
          };
          focusedInactive = {
            border = "#4C566A"; # nord3
            background = "#3B4252"; # nord1
            text = "#D8DEE9"; # nord4
            indicator = "#4C566A"; # nord3
            childBorder = "#4C566A"; # nord3
          };
          unfocused = {
            border = "#3B4252"; # nord1
            background = "#2E3440"; # nord0
            text = "#D8DEE9"; # nord4
            indicator = "#3B4252"; # nord1
            childBorder = "#3B4252"; # nord1
          };
          urgent = {
            border = "#BF616A"; # nord11
            background = "#3B4252"; # nord1
            text = "#ECEFF4"; # nord6
            indicator = "#BF616A"; # nord11
            childBorder = "#BF616A"; # nord11
          };
          placeholder = {
            border = "#2E3440"; # nord0
            background = "#2E3440"; # nord0
            text = "#D8DEE9"; # nord4
            indicator = "#2E3440"; # nord0
            childBorder = "#2E3440"; # nord0
          };
        };

        startup = [
          {
            command = "i3-msg 'log_level debug'";
            always = true;
            notification = false;
          }
          {
            command = "dex --autostart --environment i3";
            always = true;
            notification = false;
          }
          {
            command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart picom.service";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart xdg-desktop-portal.service";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart dunst.service";
            always = true;
            notification = true;
          }
          {
            command = "systemctl --user restart snixembed.service";
            always = true;
            notification = true;
          }
        ];
      };

      extraConfig = ''
        tiling_drag modifier titlebar
        exec_always --no-startup-id ${pkgs.autotiling}/bin/autotiling
      '';
    };
  };
}
