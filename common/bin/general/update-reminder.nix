{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.file."bin/update-reminder" = {
    text = ''
      #!/bin/bash

      LAST_UPDATE_FILE="$HOME/.last_update_check"
      TODAY=$(date +%s)
      DAY_NAME=$(date +%A)

      # Set Friday midnight as the weekly deadline
      FRIDAY=$(date -d "last friday" +%s)
      NEXT_FRIDAY=$(date -d "next friday" +%s)

      # Function to notify (GUI or terminal fallback)
      send_notification() {
        if command -v notify-send &>/dev/null; then
          notify-send "System Update Reminder" "$1"
        else
          echo "[Notification] $1"
        fi
      }

      # 1. If run via cron on Friday night
      if [ "$1" = "cron" ]; then
        echo "$TODAY" > "$LAST_UPDATE_FILE"
        send_notification "Time to update your system!"
        exit 0
      fi

      # 2. On login: check if the update was missed
      if [ -f "$LAST_UPDATE_FILE" ]; then
        LAST_UPDATE=$(cat "$LAST_UPDATE_FILE")
        if [ "$LAST_UPDATE" -lt "$FRIDAY" ]; then
          send_notification "You missed your Friday update! Please update now."
        fi
      else
        send_notification "You haven't updated in a while. Please do it soon."
      fi
    '';
    executable = true;
  };

  systemd.user.services.update-reminder-login = {
    Unit = {
      Description = "Run update reminder script on graphical login";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${config.home.homeDirectory}/bin/update-reminder";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
