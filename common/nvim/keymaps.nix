{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim.keymaps = [
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

    {
      mode = ["n"];
      key = ";";
      action = ":";
      options = {
        noremap = true;
      };
    }

    {
      mode = ["n"];
      key = "<CR>";
      action = "<cmd>lua require('hop').hint_words()<CR>";
      options = {
        silent = true;
        desc = "Hop to word";
      };
    }

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

    {
      mode = ["n"];
      key = "<leader>sv";
      action = "<cmd>lua _G.telescope_project_files_vertical()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Open file vertical split";
      };
    }

    {
      mode = ["n"];
      key = "<leader>sh";
      action = "<cmd>lua _G.telescope_project_files_horizontal()<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Open file horizontal split";
      };
    }

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

    {
      action = "<C-r>";
      key = "q";
      mode = "n";
      options.desc = "Easier redo.";
    }

    # Normal mode
    {
      mode = "n";
      key = "<Up>";
      action = "<Nop>";
    }
    {
      mode = "n";
      key = "<Down>";
      action = "<Nop>";
    }
    {
      mode = "n";
      key = "<Left>";
      action = "<Nop>";
    }
    {
      mode = "n";
      key = "<Right>";
      action = "<Nop>";
    }

    # Insert mode
    {
      mode = "i";
      key = "<Up>";
      action = "<Nop>";
    }
    {
      mode = "i";
      key = "<Down>";
      action = "<Nop>";
    }
    {
      mode = "i";
      key = "<Left>";
      action = "<Nop>";
    }
    {
      mode = "i";
      key = "<Right>";
      action = "<Nop>";
    }

    # Visual mode
    {
      mode = "v";
      key = "<Up>";
      action = "<Nop>";
    }
    {
      mode = "v";
      key = "<Down>";
      action = "<Nop>";
    }
    {
      mode = "v";
      key = "<Left>";
      action = "<Nop>";
    }
    {
      mode = "v";
      key = "<Right>";
      action = "<Nop>";
    }
  ];
}
