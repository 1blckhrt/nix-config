{ pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  mnw-lib = inputs.mnw.lib;
  main-neovim = mnw-lib.wrap pkgs-unstable {
    neovim = pkgs-unstable.neovim-unwrapped;
    initLua = ''
      require("blckhrt")
    '';
    plugins = {
      start = with pkgs-unstable.vimPlugins; [
        lz-n
        plenary-nvim
        snacks-nvim
        persistence-nvim
        blink-cmp
        colorful-menu-nvim
        nvim-web-devicons
        lspkind-nvim
        luasnip
        (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            lua
            nix
            python
            markdown
          ]
        ))
      ];
      opt = with pkgs-unstable.vimPlugins; [
        nvim-autopairs
        lualine-nvim
        oil-nvim
        conform-nvim
        nvim-lspconfig
        which-key-nvim
        tiny-inline-diagnostic-nvim
        render-markdown-nvim
        flash-nvim
        toggleterm-nvim
        gruvbox-material
      ];
      dev.myconfig = {
        pure = ./.;
        impure = "/' .. vim.uv.cwd()  .. '/nvim";
      };
    };
    extraBinPath = with pkgs-unstable; [
      nixd
      nixfmt
      ruff
      ty
      lua-language-server
      stylua
      markdown-oxide
      prettier
      fd
      ripgrep
    ];
  };
in
{
  home.packages = [
    main-neovim
  ];
}
