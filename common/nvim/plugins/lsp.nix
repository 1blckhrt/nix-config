_: {
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    lsp-lines.enable = true;
    lsp = {
      enable = true;

      servers = {
        ts_ls.enable = true;
        eslint.enable = true;
        basedpyright.enable = true;
        ruff.enable = true;
        marksman.enable = true;
        rust_analyzer = {
          enable = true;

          installRustc = false;
          installCargo = false;
        };
      };
    };

    none-ls = {
      enable = true;
      enableLspFormat = true;
      settings.update_in_insert = false;

      sources = {
        code_actions = {
          gitsigns.enable = true;
        };

        diagnostics = {
          statix.enable = true;
        };

        formatting = {
          alejandra.enable = true;

          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };

          stylua.enable = true;

          black = {
            enable = true;
            settings = ''
              {
                extra_args = { "--fast" },
              }
            '';
          };
        };
      };
    };

    conform-nvim = {
      enable = true;

      settings = {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };

        notify_on_error = true;

        formatters_by_ft =
          {
            python = ["black" "ruff"];
            lua = ["stylua"];
            nix = ["alejandra"];
            rust = ["rustfmt"];
          }
          // builtins.listToAttrs (map (ft: {
              name = ft;
              value = {
                __unkeyed-2 = "prettierd";
                __unkeyed-3 = "prettier";

                stop_after_first = true;
              };
            })
            ["html" "css" "javascript" "javascriptreact" "typescript" "typescriptreact" "markdown"]);
      };
    };
  };
}
