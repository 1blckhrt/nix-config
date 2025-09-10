{ config, pkgs, ... }:

{
	
services.samba = {
    enable = true;
    openFirewall = true;
    package = pkgs.sambaFull;  # Ensure full Samba support
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "hosts allow" = "0.0.0.0/0 127.0.0.1 localhost";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "music_vault" = {
        "path" = "/home/blckhrt/music";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0666";
        "directory mask" = "0777";
        "force user" = "blckhrt";
        "force group" = "users";
      };
    };
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # --- rsnapshot backups ---
  services.rsnapshot = {
    enable = true;
    extraConfig = ''
      config_version  1.2
      snapshot_root   /home/blckhrt/music-backups/
      no_create_root  1

      # Keep 4 weekly snapshots (1 month)
      retain  weekly  4

      # rsync options
      rsync_long_args --delete --numeric-ids --relative --delete-excluded

      # Backup source → destination
      backup  /home/blckhrt/music/  localhost/
    '';
  };

  # Run backups weekly
  systemd.timers.rsnapshot-weekly = {
    description = "Weekly rsnapshot backup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  systemd.services.rsnapshot-weekly = {
    description = "Run rsnapshot weekly";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.rsnapshot}/bin/rsnapshot weekly";
    };
  };

  networking.interfaces.wlo1 = {
    ipv4.addresses = [
      {
        address = "192.168.5.12";
        prefixLength = 24;
      }
    ];
  };
  networking.defaultGateway = "192.168.5.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}

