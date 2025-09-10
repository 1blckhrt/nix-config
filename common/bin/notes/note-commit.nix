{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.file."bin/note-commit" = {
    text = ''
        #!/bin/zsh

        # Get current date/time and short hostname
        DATE=$(date "+%Y%m%d-%H%M%S")
        HOST=$(hostname -s)

        # Commit message
        COMMIT_MSG="vault backup: ''${DATE} - ''${HOST}"

        # Change into vault directory
        VAULT_DIR="/home/blckhrt/Documents/Notes"
        cd "''${VAULT_DIR}" || exit 1

        # Sync first
        git pull --rebase

        # Stage, commit, and push
        git add -A
        git commit -m "''${COMMIT_MSG}"
        git push

        # Show status summary
        git status -sb
      echo "Backup complete: ''${COMMIT_MSG}"
    '';
    executable = true;
  };
}
