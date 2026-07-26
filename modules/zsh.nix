{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.zsh;

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
    home.packages = with pkgs; [
      zsh
      bat
      eza
      ripgrep
      zoxide
      starship
    ];

    home.file = {
      ".zshrc".source = config.lib.file.mkOutOfStoreSymlink zshRCPath;
      ".zshenv".source = config.lib.file.mkOutOfStoreSymlink zshEnvPath;
      ".aliases.zsh".source = config.lib.file.mkOutOfStoreSymlink zshAliasPath;
      ".zprofile".source = config.lib.file.mkOutOfStoreSymlink zProfilePath;
    };

    xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink starshipPath;
  };
}
