_: {
  programs.git = {
    enable = true;
    userName = "1blckhrt";
    userEmail = "williams.1691@wright.edu";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "!gh auth git-credential";
    };
    aliases = {
      st = "status";
      pl = "pull";
    };
  };
}
