{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec = [
      "systemctl --user restart hyprpaper.service"
      "systemctl --user restart xdg-desktop-portal.service"
      "systemctl --user restart swaync.service"
      "systemctl --user restart hyprpolkitagent.service"
      "systemctl --user restart cliphist.service"
      "systemctl --user restart waybar.service"
      "dbus-update-activation-environment --all"
      "systemctl --user import-environment XDG_DATA_DIRS PATH"
      "dbus-update-activation-environment --systemd XDG_DATA_DIRS PATH"
      "gnome-keyring-daemon --start --components=secrets"
      "nm-applet --indicator"
      "bash -c 'dbus-update-activation-environment --systemd PATH XDG_DATA_DIRS && source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh && vicinae server'"
    ];

    exec-once = [
      "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
      "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
    ];
  };
}
