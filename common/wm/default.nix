{
  pkgs,
  lib,
  ...
}: let
  mkMenu = menu: let
    configFile =
      pkgs.writeText "config.yaml"
      (lib.generators.toYAML {} {
        anchor = "center";
        font = "JetBrainsMono Nerd Font 12";
        color = "#434c5e";
        border = "#5e81ac";
        separator = " > ";
        # ...
        inherit menu;
      });
  in
    pkgs.writeShellScriptBin "my-menu" ''
      exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
in {
  imports = [./hyprpaper.nix ./fuzzel.nix ./wlogout.nix];
  home.packages = with pkgs; [
    brightnessctl
    grim
    wl-clipboard
    slurp
    snixembed
    networkmanagerapplet
    libappindicator-gtk3
    swaynotificationcenter
    cliphist
    pulseaudio
    libnotify
    pango
    playerctl
    nautilus
    hyprpolkitagent
    font-awesome
    nerd-fonts.jetbrains-mono
    pavucontrol
    flameshot
  ];

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = [
      {
        layer = "top";
        height = 28;

        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = ["clock"];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
          "tray"
        ];

        "hyprland/window" = {
          max-length = 30;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        clock = {
          interval = 30;
          format = "{:%I:%M %p}";
          tooltip-format = "{:%a, %d %b %G}";
        };

        tray = {
          icon-size = 20;
          spacing = 8;
        };

        pulseaudio = {
          format-source = "󰍬";
          format-source-muted = "󰍭";
          format = "{format_source} 󰕾 {volume}%";
          format-bluetooth = "{format_source} 󰂰 {volume}%";
          format-muted = "{format_source} 󰸈";
          max-volume = 150;
          scroll-step = 1;
        };

        bluetooth = {
          format = "";
          format-disabled = "";
          format-off = "";
          format-on = "󰂯";
          format-connected = "󰂱 {device_alias}";
          max-length = 16;
        };

        network = {
          format = "{ifname}";
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = "Disconnected";
          max-length = 32;
        };

        battery = {
          interval = 60;
          format-time = "{H}:{m}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-discharging = "{icon} {capacity}% ({time})";
          format-charging = "󰂄 {capacity}%";
          format = "";
        };
      }
    ];

    style = ''
      /* Reset all styles */
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      /* The whole bar */
      #waybar {
        background: rgba(46, 52, 64, 0.8);
        color: #D8DEE9;
        font-family: JetBrainsMono Nerd Font;
        font-size: 15px;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray,
      #bluetooth,
      #mic,
      #sound {
        padding-left: 10px;
        padding-right: 10px;
        margin-left: 10px;
        margin-right: 10px;
        border-radius: 3px;
        background-color: rgba(68, 76, 88, 0.8);
      }

      #clock {
        font-size: 16px;
        font-weight: bold;
      }

      #network {
        background-color: rgba(74, 95, 112, 0.8);
      }

      #network.disconnected {
        color: #BF616A;
      }

      #pulseaudio {
        background-color: rgba(64, 74, 87, 0.8);
      }

      #tray {
        margin-right: 10px;
      }

      #window {
        font-weight: bold;
      }

      button:hover {
        background: inherit;
        box-shadow: inherit;
      }

      #workspaces button {
        color: #D8DEE9;
        padding-left: 10px;
        padding-right: 10px;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.active {
        border-color: #A3BE8C;
        background-color: #4C566A;
      }
    '';
  };

  services = {
    swaync.enable = true;
    hyprpolkitagent.enable = true;
    cliphist.enable = true;
  };

  systemd.user.services.snixembed.Unit.After = ["graphical-session.target" "dbus.service"];

  # programs.ashell = {
  #   enable = true;
  #   systemd = {
  #     enable = true;
  #     target = "hyprland-session.target";
  #   };
  #   settings = {
  #     window_title = {
  #       truncate_title_after_length = 40;
  #     };

  #     media_player = {
  #       max_title_length = 50;
  #     };

  #     settings = {
  #       lock_cmd = "playerctl --all-players pause; hyprlock &";
  #       audio_sinks_more_cmd = "pavucontrol -t 3";
  #       audio_sources_more_cmd = "pavucontrol -t 4";
  #       wifi_mode_cmd = "nm-connection-editor";
  #     };

  #     appearance = {
  #       style = "Gradient";
  #       font_name = "JetBrainsMono NF"
  #     };

  #     modules = {
  #       left = [
  #         [
  #           "Workspaces"
  #         ]
  #         "WindowTitle"
  #       ];
  #       center = [
  #         "Clock"
  #       ];
  #       right = [
  #         "SystemInfo"
  #         [
  #           "MediaPlayer"
  #           "Privacy"
  #           "Settings"
  #           "Tray"
  #         ]
  #       ];
  #     };
  #   };
  # };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [", preferred, auto, 1"];
      exec = [
        "systemctl --user restart hyprpaper.service"
        "systemctl --user restart xdg-desktop-portal.service"
        "systemctl --user restart swaync.service"
        "systemctl --user restart hyprpolkitagent.service"
        "systemctl --user restart cliphist.service"
        "systemctl --user restart waybar.service"
        "dbus-update-activation-environment --all"
        "gnome-keyring-daemon --start --components=secrets"
        "nm-applet --indicator"
      ];

      cursor.no_hardware_cursors = true;

      "$terminal" = "${pkgs.kitty}/bin/kitty";
      "$fileManager" = "${pkgs.nautilus}/bin/nautilus";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(88c0d0ff)";
        "col.inactive_border" = "rgba(2e3440ff)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 6;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.85;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(2e3440ee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.18;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, $terminal"
        ("$mainMod, D, exec, "
          + lib.getExe (mkMenu [
            {
              key = "b";
              desc = "browser";
              cmd = "helium";
            }
            {
              key = "s";
              desc = "search";
              cmd = "fuzzel";
            }
            {
              key = "e";
              desc = "file browser";
              cmd = "nautilus";
            }
            {
              key = "d";
              desc = "discord";
              cmd = "vesktop";
            }
          ]))
        "$mainMod SHIFT, R, exec, hyprctl reload"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, E, exec, ${pkgs.wlogout}/bin/wlogout"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, +1"
        "$mainMod, mouse_up, workspace, -1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      exec-once = [
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
      ];

      env = ["XCURSOR_SIZE,15" "HYPRCURSOR_SIZE,20"];
    };
  };
}
