import time
from pathlib import Path

LAST_UPDATE_FILE = Path.home() / ".local/state/nix-config/last-update"

TIME_UNITS = (
    ("d", 86400),
    ("h", 3600),
    ("m", 60),
)


def format_age(age_seconds: float) -> str:
    for suffix, unit_seconds in TIME_UNITS:
        if age_seconds >= unit_seconds:
            return f"{int(age_seconds // unit_seconds)}{suffix} ago"
    return "just now"


def main() -> None:
    try:
        last_update_timestamp = int(LAST_UPDATE_FILE.read_text())
    except (OSError, ValueError):
        print("flake updated never")
        return

    age_seconds = time.time() - last_update_timestamp
    print(f"flake updated {format_age(age_seconds)}")


if __name__ == "__main__":
    main()
