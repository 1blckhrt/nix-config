_: {
  programs.nixvim.keymaps = [
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
      action = "<C-r>";
      key = "q";
      mode = "n";
      options.desc = "Easier redo.";
    }

    {
      action = ":Oil<CR>";
      key = "-";
      mode = "n";
      options.desc = "Open parent directory";
    }
  ];
}
