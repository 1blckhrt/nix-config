_: {
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;

      settings = {
        highlights.FloatBorder.link = "TelescopeBorder";

        float_opts = {
          border = "rounded";
          width = ''function() return math.floor(vim.o.columns * 0.8) end'';
          height = ''function() return math.floor(vim.o.lines * 0.8) end'';
        };
      };
    };

    keymaps = [
      {
        action = ":ToggleTerm direction=float<CR>";
        key = "<leader>t";
        mode = "n";
        options.desc = "Open terminal";
      }
    ];
  };
}
