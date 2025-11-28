_: {
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
      keymaps = {
        "<leader>sk" = "keymaps";
        "<leader><leader>" = "find_files";
        "<leader>ss" = "builtin";
        "<leader>sw" = "grep_string";
        "<leader>sg" = "live_grep";
        "<leader>/" = {
          action = "current_buffer_fuzzy_find";
          options.desc = "[/] Fuzzily search in current buffer";
        };
      };
      settings = {
        defaults = {
          prompt_prefix = "   ";
          selection_caret = " ";
          entry_prefix = " ";
          sorting_strategy = "ascending";

          layout_config = {
            horizontal = {
              prompt_position = "top";
              preview_width = 0.55;
            };
            width = 0.60;
            height = 0.80;
          };

          mappings = {
            i = {
              "<C-j>" = "move_selection_next";
              "<C-k>" = "move_selection_previous";
            };
            n = {
              q = "close";
            };
          };
        };
      };
    };
  };
}
