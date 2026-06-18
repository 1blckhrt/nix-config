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
    enable = lib.mkEnableOption "Neovim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      devModeScript
    ];

    programs.mnw = {
      enable = true;
      neovim = pkgs-unstable.neovim-unwrapped;
      luaFiles = [ ./configs/neovim/init.lua ];
      plugins = {
        start = with pkgs-unstable.vimPlugins; [
          lazy-nvim
          plenary-nvim
        ];
        dev.myconfig = {
          pure =
            let
              fs = lib.fileset;
            in
            fs.toSource {
              root = ./configs/neovim;
              fileset = fs.unions [
                ./configs/neovim/lua
              ];
            };
          impure = "${config.home.homeDirectory}/nix-config/modules/configs/neovim";
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
        fd
        ripgrep
        vscode-langservers-extracted
      ];
    };
  };
}
