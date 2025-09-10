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
      ensureInstalled = [
        "python"
        "javascript"
        "typescript"
        "lua"
        "rust"
      ];
    };
  };
}
