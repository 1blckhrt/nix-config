{
  programs.nixvim = {
    plugins = {
      blink-cmp = {
        enable = true;

        settings = {
          keymap = {
            preset = "default";

            # Enter accepts the current item
            "<CR>" = ["accept"];

            # Tab to move forward in the menu or fallback
            "<Tab>" = ["select_next" "fallback"];

            # Shift-Tab to move backwards
            "<S-Tab>" = ["select_prev" "fallback"];
          };

          appearance = {
            nerd_font_variant = "mono";
          };

          completion = {
            documentation = {
              auto_show = true;
            };
            ghost_text.enabled = true;
          };

          sources = {
            default = ["lsp" "path" "snippets" "buffer"];
          };
        };
      };

      luasnip = {
        enable = true;
        fromVscode = [{}];
      };

      friendly-snippets.enable = true;
    };
  };
}

