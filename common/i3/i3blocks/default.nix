{
  config,
  pkgs,
  ...
}: {
  home.file.".config/i3blocks/config".source = ./i3blocks.conf;

  home.file."bin/windowtitle" = {
    text = ''
      #!/bin/bash

      # Get focused window title
      title=$(xdotool getwindowfocus getwindowname 2>/dev/null)

      # Truncate if too long
      if [ ${"$"}{#title} -gt 50 ]; then
          title="''${title:0:47}..."
      fi

      # Output in i3blocks format
      echo "<span foreground='#2E3440' background='#88C0D0'> $title </span>"
      echo "<span foreground='#88C0D0'></span>"
    '';
    executable = true;
  };

  # Ensure i3blocks and dependencies are installed
  home.packages = with pkgs; [
    i3blocks
    pulsemixer
    xdotool
  ];
}
