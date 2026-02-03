{pkgs, ...}: {
  imports = [./clipboard.nix ./globals.nix ./keymaps.nix ./opts.nix ./performance.nix ./plugins/default.nix];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    waylandSupport = true;

    extraConfigLua = ''
      require('nordic').load()
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
  };
}
