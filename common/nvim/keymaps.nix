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

    {
      mode = ["n"];
      key = "<leader>z";
      action = "<cmd>Telekasten panel<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Panel";
      };
    }

    # Most used functions
    {
      mode = ["n"];
      key = "<leader>zf";
      action = "<cmd>Telekasten find_notes<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Find notes";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zg";
      action = "<cmd>Telekasten search_notes<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Search notes";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zd";
      action = "<cmd>Telekasten goto_today<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Goto today";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zz";
      action = "<cmd>Telekasten follow_link<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Follow link";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zn";
      action = "<cmd>Telekasten new_note<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: New note";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zc";
      action = "<cmd>Telekasten show_calendar<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Show calendar";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zb";
      action = "<cmd>Telekasten show_backlinks<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Show backlinks";
      };
    }
    {
      mode = ["n"];
      key = "<leader>zI";
      action = "<cmd>Telekasten insert_img_link<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Insert image link";
      };
    }

    # Insert mode mapping for [[
    {
      mode = ["i"];
      key = "[[";
      action = "<cmd>Telekasten insert_link<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "Telekasten: Insert link";
      };
    }
  ];
}
