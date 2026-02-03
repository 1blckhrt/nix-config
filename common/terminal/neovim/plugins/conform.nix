_: {
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    autoInstall.enable = true;
    settings = {
      notify_on_error = true;
      notify_no_formatters = true;
      format_on_save = {
        lspFallback = true;
        timeoutMs = 1000;
      };
      formatters_by_ft =
        {
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          python = ["ruff_fix" "ruff_format" "ruff_organize_imports"];
          lua = ["stylua"];
          rust = ["rustfmt"];
          nix = ["alejandra"];
          json = ["prettier"];
        }
        // builtins.listToAttrs (
          map
          (ft: {
            name = ft;
            value = {
              __unkeyed-1 = "eslint";
              __unkeyed-2 = "prettier";

              stop_after_first = true;
            };
          })
          [
            "html"
            "css"
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "markdown"
          ]
        );
    };
  };
}
