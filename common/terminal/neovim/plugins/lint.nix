_: {
  programs.nixvim.plugins = {
    none-ls = {
      enable = true;
      sources.diagnostics = {
        sqruff.enable = true;
        statix.enable = true;
        markdownlint.enable = true;
      };
    };
    lint = {
      enable = true;
      lintersByFt = {
        python = ["ruff" "mypy"];
      };
      autoCmd = {
        callback = {
          __raw = ''
            function()
              require('lint').try_lint()
            end
          '';
        };
        event = ["BufWritePost" "BufReadPost" "InsertLeave"];
      };
    };
  };
}
