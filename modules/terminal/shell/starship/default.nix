{config, ...}: {
  programs.starship = {
    enable = true;
    settings = with config.colorScheme.palette; {
      format = "$username$hostname$directory$cmd_duration$line_break$python$character";
      directory = {
        style = "#${base0D}"; # blue
      };
      character = {
        success_symbol = "[❯](#${base0E})"; # magenta
        error_symbol = "[❯](#${base08})"; # red
        vimcmd_symbol = "[❮](#${base0B})"; # green
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "#${base0A}"; # yellow
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "#${base03}"; # bright black
        detect_extensions = [];
        detect_files = [];
      };
    };
  };
}
