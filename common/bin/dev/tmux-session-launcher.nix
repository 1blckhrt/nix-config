_: {
  home.file."bin/tmux-session-launcher" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      # Collect existing sessions (may be empty)
      sessions="$(tmux list-sessions -F '#S' 2>/dev/null || true)"

      # Build menu entries
      menu_entries="+ Create New Session"
      if [ -n "$sessions" ]; then
        menu_entries="$(printf "%s\n%s" "$menu_entries" "$sessions")"
      fi

      # Pick from fuzzel menu
      choice="$(printf "%s\n" "''${menu_entries}" | fuzzel --dmenu --prompt 'tmux: ')"
      [ -z "$choice" ] && exit 0

      # User chose "Create New Session"
      if [ "$choice" = "+ Create New Session" ]; then
        new_session="$(fuzzel --dmenu --prompt 'New Session Name: ')"
        [ -z "$new_session" ] && exit 0
        kitty tmux new-session -s "$new_session"
      fi
      # Otherwise attach to existing session
      kitty --hold tmux attach-session -t "$choice"
    '';
    executable = true;
  };
}
