{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  services.tailscale = {
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.tailscale;
    enable = true;
  };
}
