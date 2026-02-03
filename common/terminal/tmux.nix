{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    prefix = "C-x";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = dotbar;
        extraConfig = ''
          set -g @tmux-dotbar-right true
          set -g @tmux-dotbar-position top
          set -g @tmux-dotbar-ssh-icon '󰌘'
          set -g @tmux-dotbar-ssh-icon-only false
          set -g @tmux-dotbar-ssh-enabled true
          # nord theme
          set -g @tmux-dotbar-bg "#2e3440"
          set -g @tmux-dotbar-fg "#4c566a"
          set -g @tmux-dotbar-fg-current "#eceff4"
          set -g @tmux-dotbar-fg-session "#d8dee9"
          set -g @tmux-dotbar-fg-prefix "#b48ead"
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-processes 'ssh "~nvim"'
          set -g @resurrect-strategy-nvim 'session'
          resurrect_dir=~/.local/share/tmux/resurrect
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g' $(readlink -f $resurrect_dir/last)"
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '5'
        '';
      }
    ];

    extraConfig = ''
          bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
          set -g set-clipboard on
          set -g detach-on-destroy off
          set -g escape-time 0
          set -g history-limit 1000000
          set -g mouse on
          set -g status-interval 3
          set -g allow-passthrough on

      set-option -g renumber-windows on
          set -g base-index 1
      setw -g pane-base-index 1

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
    '';
  };
}
