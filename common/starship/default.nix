_: let
  starshipFormat = "$os @$hostname $directory $character";
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = starshipFormat;
      add_newline = false;

      hostname = {
        format = "$hostname";
        ssh_only = false;
      };

      os = {
        disabled = false;
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Linux = "󰌽";
          Arch = "󰣇";
          Debian = "󰣚";
          NixOS = " ";
        };
      };

      directory = {
        read_only = " ";
        # Show only the last folder in the path
        truncation_length = 1;
        truncation_symbol = "";
        format = "$path";
      };

      cmd_duration = {
        format = "$duration";
      };

      sudo = {
        disabled = false;
        symbol = " ";
        format = "$symbol";
      };
    };
  };
}
