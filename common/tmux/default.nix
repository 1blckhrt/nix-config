{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    baseIndex = 1;
    prefix = "C-x";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      tmux-which-key
      resurrect
      continuum
    ];

    extraConfig = ''
      ##### Shell and Terminal #####
      set -g default-shell ${pkgs.zsh}/bin/zsh
      set -ga terminal-overrides ",*256col*:Tc"

      ##### General #####
      set -g set-clipboard on
      set -g detach-on-destroy off
      set -g escape-time 0
      set -g history-limit 1000000
      set -g mouse on
      set -g status-interval 3
      set -g allow-passthrough on
      set -g status-position top

      ##### Window / Pane Management #####
      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      ##### Resize / Navigation #####
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r h resize-pane -L 5
      bind -r l resize-pane -R 5
      bind -r m resize-pane -Z
      setw -g mode-keys vi

      ##### which-key #####
      set -g @tmux-which-key-xdg-enable 1
      set -g @tmux-which-key-disable-autobuild 1

      ##### Nord Theme #####
      set -g status-left-length 200
      set -g status-right-length 200
      set -g status-left "#[fg=#A3BE8C,bold,bg=default] #S #[fg=#D8DEE9,nobold,bg=default] | "
      set -g status-right " %Y-%m-%d  %I:%M %p"
      set -g status-justify left
      set -g status-style "bg=default"
      set -g window-status-format "#[fg=#D8DEE9,bg=default] #I:#W"
      set -g window-status-current-format "#[fg=#88C0D0,bold,bg=default]  #[underscore]#I:#W"
      set -g message-style "bg=default,fg=#D8DEE9"
      set -g mode-style "bg=#81A1C1,fg=#3B4252"
      set -g pane-active-border-style "fg=#abb2bf,bg=default"
      set -g pane-border-style "fg=brightblack,bg=default"

      ##### resurrect #####
      set -g @resurrect-dir ~/.local/share/tmux/resurrect
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-save 'S'
      set -g @resurrect-restore 'R'

      ##### continuum #####
      set -g @continuum-boot 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '10'
    '';
  };
}
