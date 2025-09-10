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

  systemd.services.tailscale = {
    enable = true;
  };

  systemd.services.tailscaled = {
    description = "Tailscale node agent";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/run/system-manager/sw/bin/tailscaled --state=/var/lib/tailscale/tailscaled.state";
      Restart = "on-failure";
      User = "root";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      NoNewPrivileges = true;
    };
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];
}
