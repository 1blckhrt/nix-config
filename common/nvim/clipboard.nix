{pkgs, ...}: {
  programs.nixvim = {
    clipboard = {
      register = "unnamedplus";

      providers = {
        wl-copy = {
          enable = true;
          package = pkgs.wl-clipboard;
        };

        xsel = {
          enable = true;
          package = pkgs.xsel;
        };

        xclip = {
          enable = true;
          package = pkgs.xclip;
        };
      };
    };
  };
}
