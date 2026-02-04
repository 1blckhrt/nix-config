_: {
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      "python" = ["mypy"];
    };
  };
}
