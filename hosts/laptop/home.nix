{
  pkgs,
  config,
  inputs,
  ...
}: let
  myPkgs = import ../../pkgs/default.nix {inherit pkgs;};
in {
  imports = [
    ../../common/desktop-apps/internet/vesktop.nix
    ../../common/terminal/default.nix
    ../../common/scripts/default.nix
    ../../common/wm/default.nix
    inputs.nix-colors.homeManagerModules.default
    inputs.vicinae.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  modules = {
    discord.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  home = {
    username = "blckhrt";
    homeDirectory = "/home/blckhrt";
    stateVersion = "25.11";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/bin"
      "$HOME/.nix-profile/bin"
    ];
    sessionVariables = {
      TERMINAL = "kitty";
      NIXOS_OZONE_WL = "1";
    };
    packages = with pkgs; [
      alejandra
    ];
    activation.linkDesktopApplications = {
      after = [
        "writeBoundary"
        "createXdgUserDirectories"
      ];
      before = [];
      data = ''
        rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
        rm -rf ${config.home.homeDirectory}/.icons/nix-icons
        mkdir -p ${config.home.homeDirectory}/.local/share/applications/home-manager
        mkdir -p ${config.home.homeDirectory}/.icons
        ln -sf ${config.home.homeDirectory}/.nix-profile/share/icons ${config.home.homeDirectory}/.icons/nix-icons

        # Check if the cached desktop files list exists
        if [ -f ${config.home.homeDirectory}/.cache/current_desktop_files.txt ]; then
          current_files=$(cat ${config.home.homeDirectory}/.cache/current_desktop_files.txt)
        else
          current_files=""
        fi

        # Symlink new desktop entries
        for desktop_file in ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop; do
          if ! echo "$current_files" | grep -q "$(basename $desktop_file)"; then
            ln -sf "$desktop_file" ${config.home.homeDirectory}/.local/share/applications/home-manager/$(basename $desktop_file)
          fi
        done

        # Update desktop database
        ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications
      '';
    };
  };

  programs.home-manager.enable = true;

  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  fonts.fontconfig = {
    defaultFonts = {
      monospace = ["JetBrainsMono"];
      serif = ["JetBrainsMono"];
      sansSerif = ["JetBrainsMono"];
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
  };
}
