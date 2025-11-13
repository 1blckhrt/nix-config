_: {
  home.file."bin/note-commit" = {
    text = ''
      #!/bin/zsh

      # Get current date/time and short hostname
      DATE=$(date "+%Y%m%d-%H%M%S")
      HOST=$(hostname -s)
      COMMIT_MSG="vault backup: ''$DATE - ''$HOST"

      VAULT_DIR="/home/blckhrt/doc"

      # Ensure we're inside vault or one of its subdirs
      if [[ "$PWD" != "$VAULT_DIR" && "$PWD" != "$VAULT_DIR"/* ]]; then
        echo "Error: must be run from within $VAULT_DIR"
        exit 1
      fi

      # Always commit from vault root
      cd "$VAULT_DIR" || exit 1

      echo "Syncing latest changes..."
      git pull --rebase || exit 1

      # Check for uncommitted changes
      if [[ -z "$(git status --porcelain)" ]]; then
        echo "No changes to commit."
        git status -sb
        echo ""
        echo "Recent commits:"
        git log -3 --oneline --decorate
        exit 0
      fi

      # Stage, commit, and push
      git add -A
      git commit -m "$COMMIT_MSG"
      git push

      # Show summary
      echo ""
      git status -sb
      echo ""
      echo "Recent commits:"
      git log -3 --oneline --decorate
      echo ""
      echo "Backup complete: $COMMIT_MSG"
    '';
    executable = true;
  };
}
