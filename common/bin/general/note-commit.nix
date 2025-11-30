_: {
  home.file."bin/note-commit" = {
    text = ''
      #!/usr/bin/env bash

      # Get current date/time and short hostname
      DATE=$(date "+%Y%m%d-%H%M%S")
      HOST=$(hostname -s)
      COMMIT_MSG="vault backup: ''$DATE - ''$HOST"

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
