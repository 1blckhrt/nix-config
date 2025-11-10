{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    prefix = "C-x";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -as terminal-features ",xterm-256color:RGB"
      set -g set-clipboard on
      set -g detach-on-destroy on
      set -g escape-time 0
      set -g history-limit 1000000
      set -g mouse on
      set -g status-interval 3
      set -g allow-passthrough on
      set -g status-position top
      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on

      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r h resize-pane -L 5
      bind -r l resize-pane -R 5
      bind -r m resize-pane -Z
      setw -g mode-keys vi

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.local/share/tmux/plugins"

      # time tracking
      bind t display-popup -E "$HOME/bin/tmux-time"

      set -g status on
      set -g status-position top
      set -g status-left-length 100
      set -g status-style "fg=#D8DEE9,bg=default"
      set -g status-left "#[fg=#A3BE8C,bold] #S"
      set -g status-right ""
      set -g status-justify absolute-centre
      set -g window-status-current-format "#[fg=#88C0D0,bold]  #[underscore]#I:#W"
      set -g window-status-format " #I:#W"
      set -g message-style "fg=#D8DEE9,bg=default"
      set -g mode-style "fg=#3B4252,bg=#81A1C1"
      set -g pane-border-style "fg=#3B4252"
      set -g pane-active-border-style "fg=#A3BE8C"
    '';
  };
}
