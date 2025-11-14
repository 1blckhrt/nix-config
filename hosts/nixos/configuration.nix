{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager.ly.enable = true;

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pulseaudio.enable = false;
    openssh.enable = true;
  };

  security.rtkit.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.blckhrt = {
      isNormalUser = true;
      description = "Parker Williams";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        vim
        gh
        vscode-fhs
      ];
    };
  };

  programs = {
    firefox.enable = true;
    zsh.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
    extraOptions = ''
      trusted-users = root blckhrt
    '';
  };

  environment.systemPackages = with pkgs; [
    helix
    git
    alejandra
    nixd
    statix
    just
  ];

  system.stateVersion = "25.05";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
  };
}
