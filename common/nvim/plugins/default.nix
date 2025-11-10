{pkgs, ...}: {
  imports = [
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
    ./oil.nix
    ./telescope.nix
    ./treesitter.nix
    ./toggleterm.nix
  ];

  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.nord-nvim
    ];

    plugins = {
      wakatime.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      render-markdown.enable = true;
      hop.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      barbecue.enable = true;
      noice.enable = true;
      tmux-navigator.enable = true;
      smart-splits.enable = true;
      guess-indent.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };
      transparent = {
        enable = true;
        autoLoad = true;
      };
      telekasten = {
        enable = true;
        settings = {
          home = "/home/blckhrt/doc/01 - Index/";
        };
      };
    };
  };
}
