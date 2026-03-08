{config, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = with config.colorScheme.palette; {
      main = {
        terminal = "kitty";
        layer = "overlay";
        font = "JetBrainsMono Nerd Font 12";
      };
      colors = {
        background = "${base00}ff";
        text = "${base06}ff";
        selection = "${base02}ff";
        selection-text = "${base06}ff";
        border = "${base0C}ff"; # cyan
        match = "${base08}ff"; # red
        selection-match = "${base08}ff"; # red
      };
      border = {
        radius = "10";
        width = "1";
      };
    };
  };
}
