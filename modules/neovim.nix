{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  cfg = config.modules.neovim;
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.nvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
