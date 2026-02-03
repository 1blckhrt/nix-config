{...}: {
  imports = [./clipboard.nix ./globals.nix ./keymaps.nix ./opts.nix ./performance.nix ./plugins/default.nix];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    waylandSupport = true;
    colorschemes.nord = {
      enable = true;
      settings = {
        italic = false;
        disable_background = true;
        borders = true;
      };
    };
  };
}
