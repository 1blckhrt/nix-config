{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = builtins.attrValues {inherit (pkgs.vimPlugins) lualine-nvim;};
    extraConfigLua = builtins.readFile ./line.lua;
  };
}
