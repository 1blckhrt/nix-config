_: {
  imports = [
    ../../modules
  ];

  modules = {
    vesktop.enable = true;
    nh.enable = true;
  };

  programs.home-manager.enable = true;

  home = {
    username = "blckhrt";
    homeDirectory = "/home/blckhrt";
    stateVersion = "25.11";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.nix-profile/bin"
    ];
  };

  targets.genericLinux = {
    enable = true;
    gpu.nvidia = {
      enable = true;
      version = "595.58.03";
      sha256 = "sha256-jA1Plnt5MsSrVxQnKu6BAzkrCnAskq+lVRdtNiBYKfk=";
    };
  };
}
