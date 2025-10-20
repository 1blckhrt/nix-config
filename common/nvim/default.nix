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

    lsp.inlayHints.enable = true;
    diagnostic.settings = {
      virtual_text = false;
      virtual_lines.current_line = true;
    };

    extraConfigLua = ''
      -- Colorscheme
      vim.cmd("colorscheme nord")

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
    '';
  };
}
