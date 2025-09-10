{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.lxqt.enable = true;
    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin.enable = true;
    displayManager.lightdm.autoLogin.user = "blckhrt";
  };
}

