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
  devModeScript = pkgs.writeShellScriptBin "nvim-dev" ''
    nix shell .#homeConfigurations.pc.config.programs.mnw.finalPackage.devMode
  '';
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      devModeScript
    ];

    programs.mnw = {
      enable = true;
      neovim = pkgs-unstable.neovim-unwrapped;
      luaFiles = [ ../dotfiles/neovim/init.lua ];
      plugins = {
        start = with pkgs-unstable.vimPlugins; [
          lazy-nvim
          plenary-nvim

          (pkgs.writeTextDir "lua/theme-palette.lua" ''
            return {
              base00 = "#${config.theme.base00}",
              base01 = "#${config.theme.base01}",
              base02 = "#${config.theme.base02}",
              base03 = "#${config.theme.base03}",
              base04 = "#${config.theme.base04}",
              base05 = "#${config.theme.base05}",
              base06 = "#${config.theme.base06}",
              base07 = "#${config.theme.base07}",
              base08 = "#${config.theme.base08}",
              base09 = "#${config.theme.base09}",
              base0A = "#${config.theme.base0A}",
              base0B = "#${config.theme.base0B}",
              base0C = "#${config.theme.base0C}",
              base0D = "#${config.theme.base0D}",
              base0E = "#${config.theme.base0E}",
              base0F = "#${config.theme.base0F}",
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
      extraBinPath = with pkgs-unstable; [
        nil
        nixfmt
        ruff
        ty
        lua-language-server
        stylua
        markdown-oxide
        prettier
        prettierd
        sqruff
        fd
        ripgrep
      ];
    };
  };
}
