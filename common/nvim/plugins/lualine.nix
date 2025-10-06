_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
        theme = "nord";
        globalstatus = true;
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };

      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch" "diff"];
        lualine_c = ["filename"];
        lualine_x = [
          {
            name = "diagnostics";
            options = {
              sources = ["nvim_diagnostic"];
              symbols = {
                error = "  ";
                warn = "  ";
                info = "  ";
                hint = "  ";
              };
            };
          }
          "fileformat"
          "filetype"
        ];
        lualine_y = ["lsp_status"];
        lualine_z = ["hostname"];
      };
    };
  };
}
