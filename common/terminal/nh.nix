_: {
  programs.nh = {
    enable = true;
    homeFlake = "/home/blckhrt/nix-config/";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
