{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.file."bin/new-note" = {
    text = ''
          #!/bin/bash

          NOTES_DIR="/home/blckhrt/Documents/Notes/Zettelkasten/Inbox"
          mkdir -p "''${NOTES_DIR}"

          # Use only timestamp for filename
          DATE=$(date "+%Y%m%d-%H%M%S")
          FILE="''${NOTES_DIR}/''${DATE}.md"

          if [ ! -f "''${FILE}" ]; then
            cat > "''${FILE}" <<'EOF'
      ---
      tags:
      hubs: put hub here
      ---

      Start writing your note here
      EOF
          fi

          nvim "''${FILE}"
    '';
    executable = true;
  };
}
