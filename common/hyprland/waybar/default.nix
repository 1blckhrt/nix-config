{pkgs, ...}: let
  custom = {
    font = "JetBrainsMono Nerd Font";
    font_size = "15px";
    font_weight = "normal";
    text_color = "#ffffff";
    background_0 = "#000000";
    background_1 = "#111111";
    border_color = "#444444";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    opacity = "0.95";
    indicator_height = "2px";
  };
in {
  home.packages = with pkgs; [
    networkmanagerapplet
    snixembed
    libappindicator-gtk3
  ];

  programs.waybar.systemd.enable = true;

  systemd.user.services.snixembed.Unit = {
    After = ["graphical-session.target" "dbus.service"];
  };

  programs.waybar.settings = [
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

      modules-center = ["hyprland/window"];

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
        expand = true; # <--- makes it stretch to center properly
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = " {volume}%";
        format-icons = {
          default = [""];
        };
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
    }
  ];

  programs.waybar.style = ''
      * {
      font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", "Font Awesome 6 Brands", monospace;
      font-size: ${custom.font_size};
      color: ${custom.text_color};
      transition: background-color 0.3s ease-out;
    }


        /* Fully transparent bar */
        window#waybar {
          background: transparent;
        }

        #custom-linuxmint,
        #workspaces,
        #window,
        #clock,
        #battery,
        #network,
        #pulseaudio,
        #tray {
          background: #000000;        /* Black bubble */
          color: #ffffff;             /* White text */
          border: 1px solid #ffffff;  /* White border */
          border-radius: 12px;
          padding: 4px 12px;          /* Space inside bubble */
          margin: 0 4px;              /* Space between bubbles */
        }

        /* Optional: tweak window bubble so long titles don't touch border */
        #window {
          padding: 4px 20px;
        }
  '';
}
