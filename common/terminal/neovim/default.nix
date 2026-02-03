{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    waylandSupport = true;
    extraPlugins = with pkgs.vimPlugins; [
      nord-nvim
    ];
    extraConfigLua = ''
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_bold = true
      require('nord').set()
    '';
  };
  imports = [./clipboard.nix ./globals.nix ./keymaps.nix ./opts.nix ./performance.nix ./plugins/default.nix];
}
