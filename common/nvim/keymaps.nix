{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim.keymaps = [
    # transparency
    {
      mode = ["n"];
      key = "<leader>t";
      action = ":TransparentToggle<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Toggle transparency";
      };
    }
    {
      mode = ["n"];
      key = "<C-n>";
      action = ":NvimTreeToggle<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = ["n"];
      key = "<leader>e";
      action = ":NvimTreeToggle<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Toggle NvimTree";
      };
    }

    # easy cmds
    {
      mode = ["n"];
      key = ";";
      action = ":";
      options = {
        noremap = true;
      };
    }

    # hop.nvim trigger
    {
      mode = ["n"];
      key = "<CR>";
      action = "<cmd>lua require('hop').hint_words()<CR>";
      options = {
        silent = true;
        desc = "Hop to word";
      };
    }

    # easy saving
    {
      mode = ["n" "v" "i"];
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Save file";
      };
    }

    # Smart-splits navigation
    {
      mode = ["n"];
      key = "<C-h>";
      action = "<cmd>lua require('smart-splits').move_cursor_left()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Move left";
      };
    }
    {
      mode = ["n"];
      key = "<C-j>";
      action = "<cmd>lua require('smart-splits').move_cursor_down()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Move down";
      };
    }
    {
      mode = ["n"];
      key = "<C-k>";
      action = "<cmd>lua require('smart-splits').move_cursor_up()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Move up";
      };
    }
    {
      mode = ["n"];
      key = "<C-l>";
      action = "<cmd>lua require('smart-splits').move_cursor_right()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Move right";
      };
    }

    # Open file in vertical split via Telescope
    {
      mode = ["n"];
      key = "<leader>v";
      action = "<cmd>lua _G.telescope_find_files_vertical()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Open file vertical split";
      };
    }

    # Open file in horizontal split via Telescope
    {
      mode = ["n"];
      key = "<leader>h";
      action = "<cmd>lua _G.telescope_find_files_horizontal()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Open file horizontal split";
      };
    }

    # Smart-splits resizing
    {
      mode = ["n"];
      key = "<A-k>";
      action = "<cmd>lua require('smart-splits').resize_up()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Resize up";
      };
    }
    {
      mode = ["n"];
      key = "<A-l>";
      action = "<cmd>lua require('smart-splits').resize_right()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Resize right";
      };
    }
    {
      mode = ["n"];
      key = "<A-j>";
      action = "<cmd>lua require('smart-splits').resize_down()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Resize down";
      };
    }
    {
      mode = ["n"];
      key = "<A-h>";
      action = "<cmd>lua require('smart-splits').resize_left()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Resize right";
      };
    }

    # Buffer management
    {
      mode = ["n"];
      key = "<leader>bn";
      action = ":bnext<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Next buffer";
      };
    }
    {
      mode = ["n"];
      key = "<leader>bp";
      action = ":bprevious<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Previous buffer";
      };
    }

    # markdown preview
    {
      "mode" = ["n"];
      key = "<leader>md";
      action = ":MarkdownPreviewToggle<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
