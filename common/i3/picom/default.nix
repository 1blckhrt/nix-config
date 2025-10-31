{
  config,
  lib,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = true;
    fade = true;
    inactiveOpacity = 0.9;
    activeOpacity = 1.0;
    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        opacity = 0.85;
        focus = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 0.9;};
      dropdown_menu = {opacity = 0.9;};
    };
    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };
      use-damage = true;
      glx-no-stencil = true;
    };
  };
}
