{
  config,
  pkgs,
  ...
}: let
  rofi-theme = pkgs.writeText "rofi-nord-theme.rasi" ''
    /* ROFI TWO LINES THEME USING THE NORD COLOR PALETTE */
    /* Author: Newman Sanchez (https://github.com/newmanls) */

    * {
        font:   "JetBrainsMono Nerd Font 12";

        nord0:     #2e3440;
        nord1:     #3b4252;
        nord2:     #434c5e;
        nord3:     #4c566a;

        nord4:     #d8dee9;
        nord5:     #e5e9f0;
        nord6:     #eceff4;

        nord7:     #8fbcbb;
        nord8:     #88c0d0;
        nord9:     #81a1c1;
        nord10:    #5e81ac;
        nord11:    #bf616a;

        nord12:    #d08770;
        nord13:    #ebcb8b;
        nord14:    #a3be8c;
        nord15:    #b48ead;

        background-color:   transparent;
        text-color:         @nord4;
        accent-color:       @nord8;

        margin:     0px;
        padding:    0px;
        spacing:    0px;
    }

    window {
        background-color:   @nord0;
        location:   north;
        width:      100%;
    }

    inputbar {
        padding:    2px 8px;
        spacing:    8px;
        children:   [ prompt, entry ];
    }

    prompt, entry, element-text, element-icon {
        vertical-align: 0.5;
    }

    prompt {
        text-color: @accent-color;
    }

    listview {
        lines:      8;
        columns:    1;
        scrollbar:  false;
    }

    element {
        padding:    8px 16px;
        spacing:    12px;
    }

    element normal urgent {
        text-color: @nord13;
    }

    element normal active {
        text-color: @accent-color;
    }

    element alternate active {
        text-color: @accent-color;
    }

    element selected {
        text-color: @nord0;
    }

    element selected normal {
        background-color:   @accent-color;
    }

    element selected urgent {
        background-color:   @nord13;
    }

    element selected active {
        background-color:   @nord8;
    }

    element-icon {
        size:   1.2em;
    }

    element-text {
        text-color: inherit;
    }
  '';
in {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 12";
    theme = "${rofi-theme}";

    # Use modes in the correct format
    extraConfig = {
      show-icons = true;

      # Drun specific settings
      drun-display-format = "{icon} {name}";
      drun-match-fields = "name,generic,exec,categories,keywords";

      # Search and matching
      matching = "fuzzy";
      tokenize = true;
      sort = true;
      sort-method = "fzf";
      case-sensitive = false;

      # Behavior
      kb-mode-next = "Shift+Right";
      kb-mode-previous = "Shift+Left";

      # Display names
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";

      # Ensure proper app discovery
      disable-history = false;
      matching-normalize = true;
      terminal = "alacritty";

      # Window positioning
      location = 0;
    };
  };

  home.packages = with pkgs; [
    shared-mime-info
    desktop-file-utils
  ];
}
