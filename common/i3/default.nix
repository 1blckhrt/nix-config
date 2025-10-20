{
  config,
  pkgs,
  ...
}: let
  mod = config.xsession.windowManager.i3.config.modifier;
in {
  imports = [
    ./dunst/default.nix
    ./i3blocks/default.nix
    ./rofi/default.nix
    ./picom/default.nix
    ./packages.nix
    ./monitors.nix
  ];

  home.file.".xinitrc" = {
    text = ''
      #!/bin/sh

      # Source home-manager environment
      [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ] && \
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      # Start i3
      exec /home/blckhrt/.nix-profile/bin/i3
    '';
    executable = true;
  };

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;

      config = {
        modifier = "Mod4";
        bars = [];

        fonts = {
          names = ["JetBrainsMono NF"];
          size = 12.0;
        };

        keybindings = {
          "${mod}+Return" = "exec --no-startup-id ${pkgs.alacritty}/bin/alacritty";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -cache-clear";
          "${mod}+Shift+r" = "exec ${pkgs.i3}/bin/i3-msg restart";
          "${mod}+Shift+e" = "exec ${pkgs.i3}/bin/i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit' 'i3-msg exit'";
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

          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          "Print" = "exec flameshot gui";

          "${mod}+Tab" = "workspace next";
          "${mod}+Shift+Tab" = "workspace prev";

          "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +10%";
          "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";
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

        floating = {
          modifier = "Mod4";
        };

        gaps = {
          inner = 12;
          smartGaps = true;
        };

        colors = {
          # Nord color palette reference
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
            command = "${pkgs.feh}/bin/feh --bg-scale /home/blckhrt/nix-config/common/i3/nord_valley.png";
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
          {
            command = "nm-applet";
            always = true;
            notification = false;
          }
          {
            command = "xclip";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart flameshot.service";
            always = true;
            notification = false;
          }
        ];
      };

      extraConfig = ''
        exec_always --no-startup-id ${pkgs.autotiling}/bin/autotiling

        bar {
          position top
          status_command i3blocks
          tray_output primary
          tray_padding 4

          colors {
            background       #2e3440
            statusline       #d8dee9

            focused_workspace   #2e3440 #2e3440 #81A1C1
            active_workspace    #2e3440 #2e3440 #8FBCBB
            inactive_workspace  #2e3440 #2e3440 #4c566a
            urgent_workspace    #2e3440 #2e3440 #BF616A
          }
        }
      '';
    };
  };
}
