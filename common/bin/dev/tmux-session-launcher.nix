_: {
  home.file."bin/tmux-session-launcher" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      # Collect active tmux sessions
      sessions="$(tmux list-sessions -F '#S' 2>/dev/null || true)"

      if [ -z "$sessions" ]; then
        # No sessions exist: prompt for a new session name
        new_session="$(fuzzel --dmenu --prompt 'New tmux session: ')"
        if [ -z "$new_session" ]; then
          notify-send "No session created"
          exit 0
        fi
        tmux new-session -s "$new_session"
        exit 0
      fi

      # Pick an existing session
      chosen="$(printf "%s\n" $sessions | fuzzel --dmenu --prompt 'tmux: ')"
      if [ -z "$chosen" ]; then
        exit 0
      fi

      # Open tmux session in kitty
      if kitty @ ls | grep -q 'tmux'; then
        # Open in a new tab of the first kitty window
        kitty @ new-tab -- tmux attach-session -t "$chosen"
      else
        # Open a new kitty window
        kitty -1 tmux attach-session -t "$chosen"
      fi
    '';
    executable = true;
  };
}
