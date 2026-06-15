{
  pkgs,
  lib,
  ...
}:
let
  bm-app = pkgs.python3Packages.buildPythonApplication rec {
    pname = "bkmrk";
    version = "0.3.0";
    pyproject = true;
    src = pkgs.fetchFromGitHub {
      owner = "jtabke";
      repo = "bkmrk";
      rev = "${version}";
      hash = "sha256-snWamxlhy2SM9tquP0yLNlmaCEeF9yCCbUj5/i0r4Jk=";
    };
    nativeBuildInputs = with pkgs.python3Packages; [
      setuptools
      wheel
    ];
    meta = with lib; {
      description = "Plain-text bookmarks manager";
      homepage = "https://github.com/jtabke/bkmrk";
      license = licenses.mit;
    };
  };
  bm-search = pkgs.writeShellApplication {
    name = "bm-search";
    runtimeInputs = with pkgs; [
      bm-app
      fzf
      jq
    ];
    text = ''
      SELECTED=$(bm list --jsonl | jq -r '"\(.title)  \(.url)"' | fzf) || exit 0
      TARGET_URL=$(printf '%s' "$SELECTED" | awk '{print $NF}')
      if [ -n "$TARGET_URL" ]; then
        helium "$TARGET_URL" > /dev/null 2>&1 &
        exit 0
      fi
    '';
  };
  bm-add = pkgs.writeShellApplication {
    name = "bm-add";
    runtimeInputs = with pkgs; [
      bm-app
      gum
    ];
    text = ''
      set -euo pipefail

      url=$(gum input --placeholder "https://...")
      [[ -z "$url" ]] && exit 0

      title=$(gum input --placeholder "Title")
      [[ -z "$title" ]] && exit 0

      tags=$(gum input --placeholder "tag1,tag2 (optional)")

      args=("$url")
      [[ -n "$title" ]] && args+=(-n "$title")
      [[ -n "$tags"  ]] && args+=(-t "$tags")

      gum confirm "Add bookmark?" && bm add "''${args[@]}" && bm sync
    '';
  };
  bm-launcher = pkgs.writeShellApplication {
    name = "bm-launcher";
    runtimeInputs = with pkgs; [
      bm-app
      jq
    ];
    text = ''
      SELECTED=$(bm list --jsonl | jq -r '"\(.title)  \(.url)"' | vicinae dmenu --placeholder "Select bookmark") || exit 0
      TARGET_URL=$(printf '%s' "$SELECTED" | awk '{print $NF}')
      if [ -n "$TARGET_URL" ]; then
        helium "$TARGET_URL" > /dev/null 2>&1 &
        exit 0
      fi
    '';
  };
in
{
  home.packages = [
    bm-app
    bm-search
    bm-add
    bm-launcher
  ];
}
