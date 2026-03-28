{pkgs, ...}: {
  imports = [
    ./animations.nix
    ./binds.nix
    ./decoration.nix
    ./exec.nix
    ./general.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source = ~/.config/hypr/monitors.conf
    '';
    settings = {
      "$mainMod" = "SUPER";

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      env = [
        "XCURSOR_SIZE,20"
        "HYPRCURSOR_SIZE,20"
      ];

      master.new_status = "master";

      cursor.no_hardware_cursors = true;

      "$terminal" = "${pkgs.kitty}/bin/kitty";
      "$fileManager" = "${pkgs.nautilus}/bin/nautilus";

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
    };
  };
}
