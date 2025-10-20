_: {
  home.file."bin/load-dev" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      dirs=(
        "$HOME/dev/"
        "$HOME/doc/"
        "$HOME/nix-config/"
      )

      for dir in "''${dirs[@]}"; do
        if [ ! -d "''${dir}" ]; then
          echo "Warning: Directory not found: ''${dir}" >&2
          continue
        fi

        session_name=$(basename "''${dir}")

        if tmux has-session -t "''${session_name}" 2>/dev/null; then
          echo "Skipping: tmux session already exists for ''${session_name}"
          continue
        fi

        echo "Starting tmux session: ''${session_name} in ''${dir}"
        tmux new-session -d -s "''${session_name}" -c "''${dir}"
      done

      echo "All done."
    '';
    executable = true;
  };
}
