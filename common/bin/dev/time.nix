{pkgs, ...}: {
  home.packages = with pkgs; [
    timewarrior
    fzf
    skim
  ];

  home.file."bin/timetrack" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Timewarrior + fzf wrapper script

      set -e

      # Colors for output
      GREEN='\033[0;32m'
      BLUE='\033[0;34m'
      YELLOW='\033[1;33m'
      NC='\033[0m' # No Color

      # Function to start tracking
      start_tracking() {
        local tags
        # Get existing tags from history
        existing_tags=$(timew tags | tail -n +4 | awk '{print $1}' | sort -u)

        # Let user select or enter new tags
        tags=$(echo "$existing_tags" | fzf \
          --multi \
          --prompt="Select tags (TAB for multi-select, ENTER when done): " \
          --preview="timew summary :ids {}" \
          --preview-window=right:50%:wrap \
          --bind="ctrl-a:select-all,ctrl-d:deselect-all" \
          --header="Select tags or type new ones" \
          --print-query | tail -1)

        if [ -n "$tags" ]; then
          timew start $tags
          echo -e "''${GREEN}Started tracking:''${NC} $tags"
        else
          echo "No tags selected. Aborted."
        fi
      }

      # Function to stop tracking
      stop_tracking() {
        if timew | grep -q "Tracking"; then
          timew stop
          echo -e "''${GREEN}Stopped tracking''${NC}"
          timew summary :ids @1
        else
          echo "No active tracking session."
        fi
      }

      # Function to show summary with fzf
      show_summary() {
        local range="''${1:-:day}"
        timew summary $range
      }

      # Function to edit/select intervals
      edit_intervals() {
        local intervals
        intervals=$(timew export | ${pkgs.jq}/bin/jq -r '.[] |
          "\(.id // "active") | \(.start[0:10]) \(.start[11:19]) - \(.end[0:19] // "now") | \(.tags | join(", "))"')

        if [ -z "$intervals" ]; then
          echo "No intervals found."
          return
        fi

        local selected
        selected=$(echo "$intervals" | fzf \
          --prompt="Select interval to delete: " \
          --preview="echo {}" \
          --header="Select interval (ESC to cancel)")

        if [ -n "$selected" ]; then
          local id=$(echo "$selected" | awk '{print $1}')
          echo -e "''${YELLOW}Delete interval @$id?''${NC} (y/n)"
          read -r confirm
          if [ "$confirm" = "y" ]; then
            timew delete @$id
            echo -e "''${GREEN}Deleted interval @$id''${NC}"
          fi
        fi
      }

      # Function to continue previous task
      continue_task() {
        local tags
        tags=$(timew export | ${pkgs.jq}/bin/jq -r '.[0].tags | join(" ")')

        if [ -n "$tags" ]; then
          timew start $tags
          echo -e "''${GREEN}Continued tracking:''${NC} $tags"
        else
          echo "No previous task found."
        fi
      }

      # Function to show menu
      show_menu() {
        local choice
        choice=$(echo -e "Start tracking\nStop tracking\nContinue last task\nShow today\nShow week\nShow month\nEdit intervals\nCancel" | \
          fzf --prompt="What do you want to do? " \
              --height=40% \
              --header="Timewarrior Menu")

        case "$choice" in
          "Start tracking") start_tracking ;;
          "Stop tracking") stop_tracking ;;
          "Continue last task") continue_task ;;
          "Show today") show_summary ":day" ;;
          "Show week") show_summary ":week" ;;
          "Show month") show_summary ":month" ;;
          "Edit intervals") edit_intervals ;;
          "Cancel") echo "Cancelled." ;;
        esac
      }

      # Main script logic
      case "$1" in
        start)
          shift
          if [ $# -eq 0 ]; then
            start_tracking
          else
            timew start "$@"
          fi
          ;;
        stop)
          stop_tracking
          ;;
        continue|cont)
          continue_task
          ;;
        edit)
          edit_intervals
          ;;
        summary|sum)
          shift
          show_summary "$@"
          ;;
        menu|"")
          show_menu
          ;;
        *)
          # Pass through to timew for other commands
          timew "$@"
          ;;
      esac
    '';
  };

  home.file."bin/tmux-time" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # -----------------------------
      # Categories
      # -----------------------------
      CATEGORIES=(
          "PROGRAMMING"
          "CONFIGURATION"
          "WASTED"
          "STOP"
      )

      # -----------------------------
      # Select a category using sk
      # -----------------------------
      selected=$(printf "%s\n" "''${CATEGORIES[@]}" | sk --margin 10% --color="bw" --bind 'q:abort')
      sk_status=$?

      if [[ $sk_status -ne 0 || -z "$selected" ]]; then
          exit 0
      fi

      # -----------------------------
      # Setup tmux status
      # -----------------------------
      tmux set -g status-interval 1  # refresh every second

      if [[ "$selected" == "STOP" ]]; then
          timew stop
          tmux set -g status-right ""
      else
          timew start "$selected"
          category="$selected"

          # Simplified elapsed time in HH:MM:SS
          tmux set -g status-right "#[fg=cyan]''${category}#[default] #[fg=green]#(timew get dom.active.duration | awk '
          {
              h=0; m=0; s=0
              match($0, /([0-9]+)H/, a); if(a[1]) h=a[1]
              match($0, /([0-9]+)M/, a); if(a[1]) m=a[1]
              match($0, /([0-9]+)S/, a); if(a[1]) s=a[1]
              printf(\"%02d:%02d:%02d\\n\", h, m, s)
          }')#[default]"
      fi
    '';
  };
}
