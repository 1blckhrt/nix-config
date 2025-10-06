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
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          NixOS = "❄️";
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
