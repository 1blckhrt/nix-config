{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.alacritty;
  inherit (config) theme;

  alacrittyPath = "${config.home.homeDirectory}/nix-config/dotfiles/alacritty";
in
{
  options.modules.alacritty = {
    enable = lib.mkEnableOption "alacritty";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.alacritty ];

    xdg.configFile."alacritty/alacritty-base.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${alacrittyPath}/alacritty-base.toml";

    xdg.configFile."alacritty/alacritty.toml".text = ''
      [general]
      import = ["${config.home.homeDirectory}/.config/alacritty/alacritty-base.toml"]

      [colors.primary]
      background = "#${theme.base00}"
      foreground = "#${theme.base05}"

      [colors.cursor]
      text = "#${theme.base00}"
      cursor = "#${theme.base05}"

      [colors.selection]
      text = "#${theme.base00}"
      background = "#${theme.base05}"

      [colors.normal]
      black = "#${theme.base01}"
      red = "#${theme.base08}"
      green = "#${theme.base0B}"
      yellow = "#${theme.base0A}"
      blue = "#${theme.base0D}"
      magenta = "#${theme.base0E}"
      cyan = "#${theme.base0C}"
      white = "#${theme.base05}"

      [colors.bright]
      black = "#${theme.base03}"
      red = "#${theme.base08}"
      green = "#${theme.base0B}"
      yellow = "#${theme.base09}"
      blue = "#${theme.base0D}"
      magenta = "#${theme.base0E}"
      cyan = "#${theme.base0C}"
      white = "#${theme.base07}"
    '';
  };
}
