{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.file."bin/upgrade" = {
    text = ''
      #!/bin/bash
      sudo pacman -Syu

      ~/bin/update-reminder cron
    '';
    executable = true;
  };

  home.file."bin/install" = {
    text = ''
       #!/bin/bash
      sudo pacman -S
    '';
  };
}
