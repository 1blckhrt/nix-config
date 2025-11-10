_: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "alacritty";
        layer = "overlay";
        font = "JetBrainsMono NF 12";
      };
      colors = {
        background = "2e3440dd";
        text = "eceff4ff";
        selection = "434c5eff";
        selection-text = "eceff4ff";
        border = "88c0d0ff";
        match = "bf616aff";
        selection-match = "bf616aff";
      };
      border = {
        radius = "10";
        width = "1";
      };
    };
  };
}
