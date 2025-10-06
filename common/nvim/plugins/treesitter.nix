_: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "python"
          "javascript"
          "typescript"
        ];
      };
    };
  };
}
