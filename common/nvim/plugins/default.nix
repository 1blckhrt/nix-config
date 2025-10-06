{pkgs, ...}: {
  imports = [./cmp.nix ./lsp.nix ./lualine.nix ./telescope.nix ./treesitter.nix ./toggleterm.nix];
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.nord-nvim
    ];

    plugins = {
      harpoon.enable = true;
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
      smart-splits.enable = true;
    };
  };
}
