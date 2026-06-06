{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  mnw-lib = inputs.mnw.lib;
  main-neovim = mnw-lib.wrap pkgs-unstable {
    neovim = pkgs-unstable.neovim-unwrapped;
    luaFiles = [ ./configs/neovim/init.lua ];
    plugins = {
      start = with pkgs-unstable.vimPlugins; [
        lazy-nvim
        plenary-nvim
      ];
      dev.myconfig = {
        pure = ./configs/neovim;
      };
    };
    extraBinPath = with pkgs-unstable; [
      nil
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
  cfg = config.modules.neovim;
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "Neovim";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      main-neovim
    ];
  };
}
