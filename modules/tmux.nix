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
        setw -g pane-base-index 1
        unbind %
        bind | split-window -h -c "#{pane_current_path}"
        unbind '"'
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        # Vim navigation integration
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
        bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'
        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
        bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
        set-option -g status-position top

        set -g status-style "bg=#${colors.base01},fg=#${colors.base05}"
        set -g status-left-length 40
        set -g status-right-length 80
        set -g status-left "#[bg=#${colors.base0D},fg=#${colors.base00},bold] #S #[bg=#${colors.base01},fg=#${colors.base0D}]"
        set -g status-right "#[fg=#${colors.base03}]#[bg=#${colors.base02},fg=#${colors.base05}] %H:%M #[bg=#${colors.base02},fg=#${colors.base04}] %d-%b-%y "
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
