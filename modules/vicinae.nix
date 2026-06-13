{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.vicinae;
  browserBookmarksScript = pkgs.writeShellScriptBin "bookmarks" ''
    # credit: https://github.com/tonybanters/dmenu-scripts/blob/master/bookmarks-dmenu.sh
    set -eu
    BOOKMARKS_FILE="''${BOOKMARKS_FILE:-$HOME/.config/bookmarks/bookmarks.txt}"
    HELIUM="$(command -v helium || true)"
    FALLBACK="$(command -v xdg-open || echo firefox)"
    mkdir -p "$(dirname "$BOOKMARKS_FILE")"
    touch "$BOOKMARKS_FILE"

    emit() {
        grep -vE '^\s*(#|$)' "$BOOKMARKS_FILE" | while IFS= read -r line; do
            case "$line" in
                *"::"*)
                    lhs="''${line%%::*}"
                    rhs="''${line#*::}"
                    lhs="$(printf '%s' "$lhs" | sed 's/[[:space:]]*$//')"
                    rhs="$(printf '%s' "$rhs" | sed 's/^[[:space:]]*//')"
                    printf '%s :: %s\n' "$lhs" "$rhs"
                    ;;
                *)
                    printf '%s :: %s\n' "$line" "$line"
                    ;;
            esac
        done
    }

    choice="$(
        emit |
        sort |
        vicinae dmenu --placeholder "Select a bookmark" ||
        true
    )"
    [ -n "$choice" ] || exit 0

    raw="''${choice##* :: }"
    raw="$(
        printf '%s' "$raw" |
        sed \
            -e 's/[[:space:]]\+#.*$//' \
            -e 's/[[:space:]]\/\/.*$//' \
            -e 's/^[[:space:]]*//' \
            -e 's/[[:space:]]*$//'
    )"

    case "$raw" in
        http://*|https://*|file://*|about:*|chrome:*)
            url="$raw"
            ;;
        *)
            url="https://$raw"
            ;;
    esac

    if [ -n "$HELIUM" ]; then
        nohup "$HELIUM" "$url" >/dev/null 2>&1 &
    else
        nohup "$FALLBACK" "$url" >/dev/null 2>&1 &
    fi
  '';
in
{
  options.modules.vicinae = {
    enable = lib.mkEnableOption "Vicinae";
  };
  config = lib.mkIf cfg.enable {
    home.packages = [
      browserBookmarksScript
    ];
    programs.vicinae = {
      enable = true;
      settings = {
        pop_to_root_on_close = true;
        font.normal = {
          size = 14;
          family = "Iosevka Nerd Font";
        };
      };
      systemd = {
        enable = true;
        autoStart = true;
      };
    };
  };
}
