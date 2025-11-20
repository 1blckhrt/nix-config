{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    prefix = "C-x";
    newSession = true;
    tmuxp.enable = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      gruvbox
    ];

    extraConfig = ''
      # Ensure PATH includes nix profile and system binaries
      set-environment -g PATH "$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH"

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

      set -g status-position top

      bind-key C-l run-shell "$HOME/bin/tmux_manager load"
      bind-key C-s run-shell "$HOME/bin/tmux_manager save"
    '';
  };
}
