{pkgs, ...}: let
  tmux2k = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux2k";
    version = "unstable-latest";
    src = pkgs.fetchFromGitHub {
      owner = "2KAbhishek";
      repo = "tmux2k";
      rev = "90707b93e4c4c3a20dc5dbff1cc9106057c70c71";
      hash = "sha256-AdKskM3gSIB+ysusNgQRp9Jb2rM2dldr/wtV2PUqTjo=";
    };
    rtpFilePath = "2k.tmux";
  };
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    prefix = "C-x";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = tmux2k;
        extraConfig = ''
          set -g @tmux2k-left-plugins "session"
          set -g @tmux2k-right-plugins "cwd"

          set -g @tmux2k-theme "duo"

          set -g @tmux2k-duo-fg "#5E81AC"
          set -g @tmux2k-duo-bg "#2e3440"
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
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

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

      set-option -g status-position top

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
