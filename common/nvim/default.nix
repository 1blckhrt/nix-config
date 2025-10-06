_: {
  imports = [
    ./keymaps.nix
    ./opts.nix
    ./clipboard.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    plugins.lazy.enable = true;

    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";

    extraConfigLua = ''
      -- Colorscheme
      vim.cmd("colorscheme lackluster")

      -- Telescope setup
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      -- helper that tries git_files, falls back to find_files
      local function project_files(opts)
        opts = opts or {}
        local ok = pcall(builtin.git_files, opts)
        if not ok then
          builtin.find_files(opts)
        end
      end

      -- vertical split version
      function _G.telescope_project_files_vertical()
        project_files({
          show_untracked = true,
          hidden = true,
          attach_mappings = function(_, map)
            map("i", "<CR>", actions.select_vertical)
            return true
          end,
        })
      end

      -- horizontal split version
      function _G.telescope_project_files_horizontal()
        project_files({
          show_untracked = true,
          hidden = true,
          attach_mappings = function(_, map)
            map("i", "<CR>", actions.select_horizontal)
            return true
          end,
        })
      end

      -- Highlight on yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
        pattern = "*",
        desc = "Highlight selection on yank",
        callback = function()
          vim.highlight.on_yank({ timeout = 200, visual = true })
        end,
      })

      -----------------------------------------------------------------------
      -- Harpoon v2 setup
      -----------------------------------------------------------------------
      local harpoon = require("harpoon")
      harpoon:setup()

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Toggle quick menu
      map("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, vim.tbl_extend("force", { desc = "Harpoon: toggle quick menu (Ctrl-e)" }, opts))

      -- Add current file
      map("n", "<leader>m", function()
        harpoon:list():add()
      end, vim.tbl_extend("force", { desc = "Harpoon: add file" }, opts))

      -- Jump to marked files
      map("n", "<leader>1", function() harpoon:list():select(1) end,
        vim.tbl_extend("force", { desc = "Harpoon: go to 1" }, opts))
      map("n", "<leader>2", function() harpoon:list():select(2) end,
        vim.tbl_extend("force", { desc = "Harpoon: go to 2" }, opts))
      map("n", "<leader>3", function() harpoon:list():select(3) end,
        vim.tbl_extend("force", { desc = "Harpoon: go to 3" }, opts))
      map("n", "<leader>4", function() harpoon:list():select(4) end,
        vim.tbl_extend("force", { desc = "Harpoon: go to 4" }, opts))
    '';
  };
}
