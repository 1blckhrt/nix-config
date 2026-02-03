_: {
  imports = [./cmp.nix ./conform.nix ./lsp.nix ./lualine.nix ./snacks.nix];
  programs.nixvim.plugins = {
    web-devicons.enable = true;
    neo-tree.enable = true;
    auto-session.enable = true;
    colorful-menu.enable = true;
    tiny-inline-diagnostic.enable = true;
    gitsigns.enable = true;
    markdown-preview.enable = true;
    typescript-tools.enable = true;
    noice.enable = true;
    tmux-navigator.enable = true;
    treesitter.enable = true;
    flash.enable = true;
    which-key.enable = true;
    nvim-autopairs.enable = true;
  };
}
