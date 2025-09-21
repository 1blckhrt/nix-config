{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "python"
          "javascript"
          "typescript"
          "lua"
          "rust"
        ];
      };
    };
  };
}
