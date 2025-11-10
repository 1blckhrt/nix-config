_: {
  programs.git = {
    enable = true;
    userName = "1blckhrt";
    userEmail = "143528734+1blckhrt@users.noreply.github.com";
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
