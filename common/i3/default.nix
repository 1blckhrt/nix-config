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
  ];

  home.file = {
    ".xinitrc" = {
      text = ''
        #!/bin/sh
        exec /home/blckhrt/.nix-profile/bin/i3
      '';
      executable = true;
    };

    "bin/brightness" = {
      text = ''
        #!/usr/bin/env bash
        case "$1" in
          up) brightnessctl set +10% ;;
          down) brightnessctl set 10%- ;;
        esac
      '';
      executable = true;
    };

    "bin/power" = {
      text = ''
        #!/usr/bin/env bash
        chosen=$(printf " Logout\n Reboot\n Poweroff" | rofi -dmenu -p "Power")

        case "$chosen" in
          " Logout") i3-msg exit ;;
          " Reboot") systemctl reboot ;;
          " Poweroff") systemctl poweroff ;;
        esac
      '';
      executable = true;
    };

    "bin/screenshot" = {
      text = ''
        #!/usr/bin/env bash

        choice=$(printf "Full Screen\nWindow\nRegion" | rofi -dmenu -p "Screenshot:")
        [[ -z "$choice" ]] && exit 0

        dir="$HOME/Pictures/Screenshots"
        mkdir -p "$dir"
        file="$dir/$(date +%F_%T).png"

        sleep 0.5

        picom_running=false
        if pgrep -x picom > /dev/null; then
            picom_running=true
            killall picom
            sleep 0.2
        fi

        case "$choice" in
            "Full Screen") maim "$file" ;;
            "Window") maim -i "$(xdotool getactivewindow)" "$file" ;;
            "Region") maim -s "$file" ;;
        esac

        if $picom_running; then
            picom --daemon &
        fi

        if [[ -f "$file" ]]; then
            xclip -selection clipboard -t image/png -i "$file"
            notify-send "Screenshot saved and copied to clipboard" "$file"
        else
            notify-send "Screenshot failed" "No file was created"
        fi
      '';
      executable = true;
    };

    "bin/music" = {
      text = ''
        #!/usr/bin/env bash

        MPD_HOST="localhost"
        MUSIC_MOUNT="$HOME/Music/pi_music"
        SAMBA_SHARE="//100.117.199.69/music"
        SAMBA_USER="pi"

        mkdir -p "$MUSIC_MOUNT"

        if ! mountpoint -q "$MUSIC_MOUNT"; then
            echo "Mounting Samba share..."
            if ! sudo mount -t cifs "$SAMBA_SHARE" "$MUSIC_MOUNT" -o user="$SAMBA_USER"; then
                notify-send "🎵 Music Error" "Failed to mount Samba share $SAMBA_SHARE"
                exit 1
            fi
            mpc update
        fi

        if ! mpc status >/dev/null 2>&1; then
            notify-send "🎵 MPD Error" "MPD is not running locally"
            exit 1
        fi

        options="▶️ Play/Pause
        ⏭️ Next
        ⏮️ Previous
        ⏹️ Stop
        🎵 Now Playing
        📂 Choose Playlist
        💿 Browse Albums
        🔍 Search Song"

        chosen=$(echo "$options" | rofi -dmenu -i -p "Music Dashboard")

        case "$chosen" in
            "▶️ Play/Pause") mpc toggle ;;
            "⏭️ Next") mpc next ;;
            "⏮️ Previous") mpc prev ;;
            "⏹️ Stop") mpc stop ;;
            "🎵 Now Playing")
                nowplaying=$(mpc current)
                [ -z "$nowplaying" ] && nowplaying="Nothing playing"
                notify-send "Now Playing" "$nowplaying"
                ;;
            "📂 Choose Playlist")
                playlists=$(mpc lsplaylists)
                [ -z "$playlists" ] && notify-send "No playlists found" && exit 0
                selected=$(echo "$playlists" | rofi -dmenu -i -p 'Select Playlist')
                [ -n "$selected" ] && mpc clear && mpc load "$selected" && mpc play
                ;;
            "💿 Browse Albums")
                albums=$(mpc list album | sort -u)
                [ -z "$albums" ] && notify-send "No albums found" && exit 0
                album=$(echo "$albums" | rofi -dmenu -i -p 'Select Album')
                [ -n "$album" ] && mpc clear && mpc findadd album "$album" && mpc play
                ;;
            "🔍 Search Song")
                songs=$(mpc listall | rofi -dmenu -i -p 'Search Song')
                [ -z "$songs" ] && notify-send "No songs found" && exit 0
                mpc clear && mpc add "$songs" && mpc play
                ;;
            *) exit 0 ;;
        esac
      '';
      executable = true;
    };

    "bin/clipboard" = {
      text = ''
        #!/usr/bin/env bash

        SELECTION=$(cliphist list | rofi -dmenu -p "Clipboard")

        if [ -n "$SELECTION" ]; then
            cliphist decode <<< "$SELECTION" | xsel --clipboard --input
            cliphist decode <<< "$SELECTION" | xsel --primary --input
            notify-send "Clipboard" "Copied selection to clipboard"
        fi
      '';
      executable = true;
    };
  };

  xsession = {
    enable = true;

    initExtra = ''
      systemctl --user import-environment PATH
      systemctl --user start graphical-session.target
    '';

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
          "${mod}+Return" = "exec --no-startup-id alacritty";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -cache-clear";
          "${mod}+Shift+r" = "exec ${pkgs.i3}/bin/i3-msg restart";
          "${mod}+Shift+e" = "exec --no-startup-id ~/bin/power";

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

          "Print" = "exec --no-startup-id ~/bin/screenshot";

          "${mod}+Tab" = "workspace next";
          "${mod}+Shift+Tab" = "workspace prev";

          "XF86MonBrightnessUp" = "exec --no-startup-id ~/bin/brightness up";
          "XF86MonBrightnessDown" = "exec --no-startup-id ~/bin/brightness down";

          "${mod}+v" = "exec --no-startup-id ~/bin/clipboard";
          "${mod}+m" = "exec --no-startup-id ~/bin/music";
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
          focused = {
            border = "#81A1C1";
            background = "#3B4252";
            text = "#ECEFF4";
            indicator = "#88C0D0";
            childBorder = "#81A1C1";
          };

          focusedInactive = {
            border = "#4C566A";
            background = "#3B4252";
            text = "#D8DEE9";
            indicator = "#4C566A";
            childBorder = "#4C566A";
          };

          unfocused = {
            border = "#3B4252";
            background = "#2E3440";
            text = "#D8DEE9";
            indicator = "#3B4252";
            childBorder = "#3B4252";
          };

          urgent = {
            border = "#BF616A";
            background = "#3B4252";
            text = "#ECEFF4";
            indicator = "#BF616A";
            childBorder = "#BF616A";
          };

          placeholder = {
            border = "#2E3440";
            background = "#2E3440";
            text = "#D8DEE9";
            indicator = "#2E3440";
            childBorder = "#2E3440";
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
            command = "${pkgs.feh}/bin/feh --bg-scale /home/blckhrt/nix-config/common/i3/nord_valley.png";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart xdg-desktop-portal.service";
            always = true;
            notification = true;
          }
          {
            command = "systemctl --user restart dunst.service";
            always = true;
            notification = true;
          }
          {
            command = "systemctl --user restart picom.service";
            always = true;
            notification = true;
          }
          {
            command = "snixembed";
            always = true;
            notification = true;
          }
          {
            command = "nm-applet";
            always = true;
            notification = true;
          }
          {
            command = "xclip";
            always = true;
            notification = true;
          }
          {
            command = "systemctl --user restart cliphist.service";
            always = true;
            notification = true;
          }
        ];
      };

      extraConfig = ''
        exec_always --no-startup-id ${pkgs.autotiling}/bin/autotiling

        bar {
          position top
          font pango:JetBrainsMono NF 10
          status_command i3blocks
          tray_padding 4
          tray_output primary

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
