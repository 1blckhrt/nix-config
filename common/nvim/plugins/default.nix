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
    extraPlugins = with pkgs.vimPlugins; [
      mini-nvim
      plenary-nvim
      nui-nvim
      nvim-notify
    ];

    plugins = {
      wakatime.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      render-markdown.enable = true;
      hop.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      tmux-navigator.enable = true;
      smart-splits.enable = true;
      guess-indent.enable = true;
      gitsigns.enable = true;

      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      };

      transparent = {
        enable = true;
        autoLoad = true;
      };

      telekasten = {
        enable = true;
        settings.home = "/home/blckhrt/doc/01 - Index/";
      };
    };
  };
}
