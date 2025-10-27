{
  config,
  lib,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.picom;
    backend = "glx";
    vSync = true;
    shadow = true;
    fade = true;
    fadeSteps = [0.03 0.03];
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
