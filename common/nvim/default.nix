{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./keymaps.nix
    ./opts.nix
    ./plugins/default.nix
  ];

  programs.nixvim = {
    enable = true;
    plugins.lazy.enable = true;

    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";

    extraConfigLua = ''
            vim.cmd("colorscheme lackluster")
              -- Custom function for opening in vertical split
              function _G.telescope_find_files_vertical()
                require('telescope.builtin').find_files({
                  hidden = true,
                  attach_mappings = function(prompt_bufnr, map)
                    local actions = require('telescope.actions')
                    map('i', '<CR>', actions.select_vertical)
                    return true
                  end
                })
              end

              -- Custom function for opening in horizontal split
              function _G.telescope_find_files_horizontal()
                require('telescope.builtin').find_files({
                  hidden = true,
                  attach_mappings = function(prompt_bufnr, map)
                    local actions = require('telescope.actions')
                    map('i', '<CR>', actions.select_horizontal)
                    return true
                  end
                })
              end

      				vim.api.nvim_create_autocmd("textyankpost", {
      	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
      	pattern = "*",
      	desc = "highlight selection on yank",
      	callback = function()
      		vim.highlight.on_yank({ timeout = 200, visual = true })
      	end,
      })

    '';
  };
}
