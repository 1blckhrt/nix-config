{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.zsh;

  mkSymlink = config.lib.file.mkOutOfStoreSymlink;

  zshPath = "${config.home.homeDirectory}/nix-config/dotfiles/zsh";
  starshipPath = "${config.home.homeDirectory}/nix-config/dotfiles/starship/starship.toml";

  zshRCPath = "${zshPath}/.zshrc";
  zshEnvPath = "${zshPath}/.zshenv";
  zshAliasPath = "${zshPath}/.aliases.zsh";
  zProfilePath = "${zshPath}/.zprofile";
in
{
  options.modules.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        zsh
        bat
        eza
        ripgrep
        zoxide
        starship
        atuin
        ;
    };

    home.file = {
      ".zshrc".source = mkSymlink zshRCPath;
      ".zshenv".source = mkSymlink zshEnvPath;
      ".aliases.zsh".source = mkSymlink zshAliasPath;
      ".zprofile".source = mkSymlink zProfilePath;
    };

    xdg.configFile."starship.toml".source = mkSymlink starshipPath;
  };
}
