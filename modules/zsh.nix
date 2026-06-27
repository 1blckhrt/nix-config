{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.zsh;
  zshRCPath = "${config.home.homeDirectory}/nix-config/dotfiles/zsh/.zshrc";
  zshEnvPath = "${config.home.homeDirectory}/nix-config/dotfiles/zsh/.zshenv";
  zshAliasPath = "${config.home.homeDirectory}/nix-config/dotfiles/zsh/aliases.zsh";
  promptPath = "${config.home.homeDirectory}/nix-config/dotfiles/starship/starship.toml";
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
      "aliases.zsh".source = config.lib.file.mkOutOfStoreSymlink zshAliasPath;
    };
    xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink promptPath;
  };
}
