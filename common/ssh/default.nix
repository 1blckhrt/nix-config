_: {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "pi" = {
        hostname = "100.117.199.69";
      };

      "*" = {
        user = "blckhrt";
      };
    };
  };
}
