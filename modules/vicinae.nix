{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.vicinae;
  browserBookmarksScript = pkgs.writeShellScriptBin "bookmarks" ''
    chosen=$(awk -F'\t' '{print $1 "\t" $2}' ~/.config/bookmarks.txt | vicinae dmenu --placeholder "Select a bookmark")
    [ -z "$chosen" ] && exit 0
    url=$(echo "$chosen" | cut -f2)
    helium "$url"
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
      systemd = {
        enable = true;
        autoStart = true;
      };
    };
  };
}
