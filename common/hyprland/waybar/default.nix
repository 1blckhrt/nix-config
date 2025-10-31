{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        position = "top";
        layer = "top";
        height = 42;
        margin-top = 5;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;

        modules-left = [
          "custom/linuxmint"
          "hyprland/workspaces"
        ];

        modules-center = ["hyprland/window" "custom/notifications"];

        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "tray"
        ];

        "custom/linuxmint" = {
          format = "  ";
          tooltip = true;
          tooltip-format = "Linux Mint";
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 60;
          tooltip = false;
          expand = true;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = " {volume}%";
          format-icons = {default = [""];};
          scroll-step = 2;
          on-click = "pavucontrol";
        };

        "network" = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-full = "{icon} {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        "clock" = {
          format = "{:%H:%M | %e %B}";
          tooltip = true;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "tray" = {
          icon-size = 16;
          spacing = 4;
        };

        "custom/notifications" = {
          tooltip = false;
          format = "{icon} Notifications";
          format-icons = {
            notification = "󱥁 <span foreground='red'><sup></sup></span>";
            none = "󰍥 ";
            dnd-notification = "󱙍 <span foreground='red'><sup></sup></span>";
            dnd-none = "󱙎 ";
            inhibited-notification = "󱥁 <span foreground='red'><sup></sup></span>";
            inhibited-none = "󰍥 ";
            dnd-inhibited-notification = "󱙍 <span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "󱙎 ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      }
    ];

    style = ''
            /* Nord palette */
      @define-color nord0 #2E3440;
      @define-color nord1 #3B4252;
      @define-color nord2 #434C5E;
      @define-color nord3 #4C566A;
      @define-color nord4 #D8DEE9;
      @define-color nord5 #E5E9F0;
      @define-color nord6 #ECEFF4;
      @define-color nord7 #8FBCBB;
      @define-color nord8 #88C0D0;
      @define-color nord9 #81A1C1;
      @define-color nord10 #5E81AC;
      @define-color nord11 #BF616A;
      @define-color nord12 #D08770;
      @define-color nord13 #EBCB8B;
      @define-color nord14 #A3BE8C;
      @define-color nord15 #B48EAD;

      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", "Font Awesome 6 Brands", monospace;
        font-size: 15px;
        color: @nord6;
        transition: background-color 0.3s ease-out;
      }

      window#waybar {
        background: transparent;
      }

      #custom-linuxmint,
      #workspaces,
      #window,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #tray,
      #custom-notifications {
        background: @nord0;
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 10px;
      }

      #workspaces button {
        padding: 0 8px;
        background: transparent;
        color: @nord4;
      }

      #workspaces button.active {
        color: @nord8;
      }

      #workspaces button.urgent {
        color: @nord11;
      }

      #workspaces button:hover {
        background: @nord1;
      }

      #battery.warning {
        color: @nord13;
      }

      #battery.critical {
        color: @nord11;
      }

      #battery.charging {
        color: @nord14;
      }
    '';
  };

  # Optional for system tray in Wayland
  home.packages = with pkgs; [
    snixembed
    networkmanagerapplet
    libappindicator-gtk3
  ];

  systemd.user.services.snixembed.Unit.After = [
    "graphical-session.target"
    "dbus.service"
  ];
}
