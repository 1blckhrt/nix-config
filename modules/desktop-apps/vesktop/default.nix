_: {
  programs.vesktop = {
    enable = true;
    settings = {
      arRPC = true;
      checkUpdates = false;
      hardwareAcceleration = true;
    };
  };

  services.arrpc.enable = true;
}
