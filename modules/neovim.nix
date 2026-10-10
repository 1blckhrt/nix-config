{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  cfg = config.modules.neovim;
  inherit (config) theme;
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.mnw = {
      enable = true;
      neovim = pkgs-unstable.neovim-unwrapped;
      luaFiles = [ ../dotfiles/neovim/init.lua ];
      plugins = {
        start =
          (builtins.attrValues {
            inherit (pkgs-unstable.vimPlugins) lazy-nvim plenary-nvim;
          })
          ++ [
            (pkgs.writeTextDir "lua/theme-palette.lua" ''
              return {
                base00 = "#${theme.base00}",
                base01 = "#${theme.base01}",
                base02 = "#${theme.base02}",
                base03 = "#${theme.base03}",
                base04 = "#${theme.base04}",
                base05 = "#${theme.base05}",
                base06 = "#${theme.base06}",
                base07 = "#${theme.base07}",
                base08 = "#${theme.base08}",
                base09 = "#${theme.base09}",
                base0A = "#${theme.base0A}",
                base0B = "#${theme.base0B}",
                base0C = "#${theme.base0C}",
                base0D = "#${theme.base0D}",
                base0E = "#${theme.base0E}",
                base0F = "#${theme.base0F}",
              }
            '')
          ];
        dev.myconfig = {
          pure =
            let
              fs = lib.fileset;
            in
            fs.toSource {
              root = ../dotfiles/neovim;
              fileset = fs.unions [
                ../dotfiles/neovim/lua
              ];
            };
          impure = "${config.home.homeDirectory}/nix-config/dotfiles/neovim";
        };
      };
      extraBinPath = builtins.attrValues {
        inherit (pkgs-unstable)
          wl-clipboard
          nil
          nixfmt
          ruff
          ty
          lua-language-server
          stylua
          vscode-langservers-extracted
          superhtml
          sqruff
          fd
          ripgrep
          rumdl
          ;
      };
    };
  };
}
