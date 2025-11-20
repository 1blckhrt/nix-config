{
  config,
  pkgs,
  ...
}: {
  home.file."bin/tmux-setup" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      create_session() {
          local session_name="$1"
          local dir="$2"

          if tmux has-session -t "$session_name" 2>/dev/null; then
              echo "Session '$session_name' already exists, skipping."
          else
              echo "Creating session '$session_name' in directory '$dir'"
              tmux new-session -d -s "$session_name" -c "$dir"
              tmux send-keys -t "$session_name" "nvim" C-m
          fi
      }

      # Base sessions
      create_session "nix-config" "$HOME/nix-config"
      create_session "doc" "$HOME/doc"

      # Sessions for 1-level-deep subdirectories in ~/dev
      for dir in "$HOME/dev"/*/; do
          [ -d "$dir" ] || continue
          session_name=$(basename "$dir")
          create_session "$session_name" "$dir"
      done

      echo "All sessions created."
    '';
    executable = true;
  };
}
