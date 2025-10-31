_: {
  home.file."bin/note-commit" = {
    text = ''
      #!/usr/bin/env zsh

      DATE=$(date "+%Y%m%d-%H%M%S")
      HOST=$(hostname -s)
      COMMIT_MSG="vault backup: ''${DATE} - ''${HOST}"
      VAULT_DIR="$HOME/doc"

      # Always commit from vault root
      cd "$VAULT_DIR" || exit 1

      # Only commit if there are changes
      if [[ -n "$(git status --porcelain)" ]]; then
        echo "Committing local changes..."
        git add -A
        git commit -m "''${COMMIT_MSG}"
      else
        echo "No local changes to commit."
      fi

      # Pull remote changes (fast-forward only)
      echo "Syncing latest changes..."
      git pull --ff-only || echo "⚠️ Git pull failed — check your branch or remote"

      # Push local commits
      git push || echo "⚠️ Git push failed"

      # Show status and last 3 commits
      git status -sb
      echo ""
      echo "Last 3 commits:"
      git log -3 --oneline --decorate
      echo ""
      echo "Backup complete: ''${COMMIT_MSG}"
    '';
    executable = true;
  };
}
