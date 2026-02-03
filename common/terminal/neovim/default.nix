{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    waylandSupport = true;
    extraPlugins = with pkgs.vimPlugins; [
      nordic-nvim
    ];
    extraConfigLuaPre = ''
      require("nordic").setup({
      	bold_keywords = true,
      	italic_comments = false,
      	transparent = {
      		bg = true,
      	},
      	swap_backgrounds = true,
      	cursorline = {
      		bold = true,
      		bold_number = true,
      	},
      })

    '';
    extraConfigLua = ''
      require('nordic').load()
    '';
  };
  imports = [./clipboard.nix ./globals.nix ./keymaps.nix ./opts.nix ./performance.nix ./plugins/default.nix];
}
