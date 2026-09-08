{
  pkgs,
  config,
  lib,
  ...
}:
let
  colors = config.theme;
  cfg = config.modules.tmux;
in
{
  options.modules.tmux = {
    enable = lib.mkEnableOption "tmux";
  };
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-x";
      terminal = "tmux-256color";
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 1000000;
      mouse = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        tmux-session-manager
      ];
      extraConfig = ''
        bind r source-file ~/.config/tmux/tmux.conf
        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -g set-clipboard on
        set -g detach-on-destroy off
        set -g status-interval 3
        set -g allow-passthrough on
        set-option -g renumber-windows on

        bind -n C-h if-shell -F "#{@is_vim}" "send-keys C-h"  "select-pane -L"
        bind -n C-j if-shell -F "#{@is_vim}" "send-keys C-j"  "select-pane -D"
        bind -n C-k if-shell -F "#{@is_vim}" "send-keys C-k"  "select-pane -U"
        bind -n C-l if-shell -F "#{@is_vim}" "send-keys C-l"  "select-pane -R"
        bind -n C-\\ if-shell -F "#{@is_vim}" "send-keys C-\\" "select-pane -l"

        set -g automatic-rename on
        set -g automatic-rename-format "#{window_icon} #{pane_current_command}"

        # Center the window list on the status bar
        set -g status-justify centre

        setw -g pane-base-index 1
        unbind %
        bind | split-window -h -c "#{pane_current_path}"
        unbind '"'
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        set-option -g status-position top

        set -g status-style "bg=#${colors.base01},fg=#${colors.base05}"
        set -g status-left-length 40
        set -g status-right-length 80
        set -g status-left "#[bg=#${colors.base0D},fg=#${colors.base00},bold] 󰨇  #S #[bg=#${colors.base01},fg=#${colors.base0D}]"
        set -g status-right "#[bg=#${colors.base01},fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base00},bold]   #h "

        setw -g window-status-format "#[fg=#${colors.base04}] #I:#W "
        setw -g window-status-current-format "#[bg=#${colors.base02},fg=#${colors.base0B},bold] #I:#W "

        set -g pane-border-style "fg=#${colors.base02}"
        set -g pane-active-border-style "fg=#${colors.base0D}"
        set -g message-style "bg=#${colors.base02},fg=#${colors.base0D}"
        set -g message-command-style "bg=#${colors.base02},fg=#${colors.base0D}"
        setw -g clock-mode-colour "#${colors.base0D}"
        set -g display-panes-colour "#${colors.base04}"
        set -g display-panes-active-colour "#${colors.base0D}"
        set -g window-style 'bg=default'
        set -g window-active-style 'bg=default'
        set -g status-style 'bg=default'
      '';
    };
  };
}
