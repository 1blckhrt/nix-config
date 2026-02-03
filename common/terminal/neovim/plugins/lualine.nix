_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "nordic";
        globalstatus = true;
        disabled_filetypes.__unkeyed-1 = "nvim-tree";
      };
    };
  };
}
