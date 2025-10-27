_: {
  programs.nixvim = {
    extraConfigLua = builtins.readFile ./cmp.lua;
    plugins = {
      luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      cmp-cmdline.enable = true;
      copilot-cmp.enable = true;

      copilot-lua = {
        enable = true;
        settings = {
          suggestion.enabled = false;
          panel.enabled = false;
        };
      };

      lspkind = {
        enable = true;
        cmp.enable = true;
        settings.mode = "symbol";
      };

      cmp = {
        enable = true;

        settings = {
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };

          autoEnableSources = true;
          snippet.expand = "luasnip";
          experimental.ghost_text = true;
          formatting.fields = ["kind" "abbr" "menu"];

          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual";
            };

            documentation = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:Normal";
            };
          };

          sources = [
            {name = "nvim_lsp";}
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            {name = "copilot";}
            {
              name = "path";
              keywordLength = 3;
            }
            {
              name = "luasnip";
              keywordLength = 3;
            }
          ];

          mapping = {
            "<Tab>".__raw = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-e>".__raw = "cmp.mapping.abort()";
            "<CR>".__raw = "cmp.mapping.confirm({ select = true })";
            "<S-CR>".__raw = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };
    };
  };
}
