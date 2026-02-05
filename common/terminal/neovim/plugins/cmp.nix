_: {
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        "<Down>" = ["select_next" "fallback"];
        "<Up>" = ["select_prev" "fallback"];
        "<Tab>" = ["accept" "fallback"];
        "<C-space>" = ["show" "show_documentation" "hide_documentation"];
        "<C-e>" = ["hide"];
      };
      appearance = {
        nerd_font_variant = "normal";
      };
      completion = {
        ghost_text.enabled = true;
        accept = {
          auto_brackets = {
            enabled = true;
            semantic_token_resolution = {
              enabled = false;
            };
          };
        };
      };
      signature = {
        enabled = true;
      };
      sources = {
        cmdline = [];
        providers = {
          lazydev = {
            name = "LazyDev";
            module = "lazydev.integrations.blink";
            score_offset = 100;
          };
          path.enabled = true;
          buffer = {
            enabled = true;
            score_offset = -7;
          };
          lsp = {
            fallbacks = [];
            enabled = true;
          };
        };
      };
    };
  };
}
