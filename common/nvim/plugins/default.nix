{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./cmp.nix ./lsp.nix ./lualine.nix ./telescope.nix ./obsidian.nix ./treesitter.nix ./toggleterm.nix];
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.lackluster-nvim
    ];

    plugins = {
      smear-cursor.enable = true;
      neoscroll.enable = true;
      wakatime.enable = true;
      nvim-tree.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      render-markdown.enable = true;
      tiny-inline-diagnostic.enable = true;
      hop.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      barbecue.enable = true;
      noice.enable = true;
      tmux-navigator.enable = true;
      rustaceanvim.enable = true;
      todo-comments.enable = true;
      smart-splits.enable = true;
      markdown-preview.enable = true;
      zen-mode.enable = true;
    };
  };
}
