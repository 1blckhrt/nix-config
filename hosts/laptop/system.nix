{
  config,
  lib,
  pkgs,
  system-graphics,
  system-manager,
  ...
}: {
  nixpkgs.hostPlatform = "x86_64-linux";

  system-manager.allowAnyDistro = true;

  system-graphics.enable = true;
  system-graphics.enable32Bit = true;
}
