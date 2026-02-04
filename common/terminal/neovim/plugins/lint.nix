_: {
  programs.nixvim.plugins.none-ls = {
    enable = true;
    sources.diagnostics = {
      sqruff.enable = true;
      statix.enable = true;
      markdownlint.enable = true;
      mypy = {
        enable = true;
        settings = {
          extra_args = ["--python-executable" ".venv/bin/python"];
        };
      };
    };
  };
}
