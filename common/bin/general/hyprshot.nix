_: {
  home.file."bin/hyprshot" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p "$HOME/Pictures/Screenshots"
      REGION=$(slurp) || exit 1
      FILE="$HOME/Pictures/Screenshots/Screenshot-$(date +%F_%T).png"
      grim -g "$REGION" "$FILE" || exit 1
      wl-copy < "$FILE"
      notify-send "Screenshot saved and copied!"
    '';
  };
}
