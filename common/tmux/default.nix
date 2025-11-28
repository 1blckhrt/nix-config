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
    baseIndex = 1;
    prefix = "C-x";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = tmux2k;
        extraConfig = ''
          set -g @tmux2k-theme 'gruvbox'
          set -g @tmux2k-icons-only true
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all "sed -i 's/--cmd lua.*--cmd set packpath/--cmd \"lua/g; s/--cmd set rtp.*\$/\"/' $resurrect_dir/last"
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes '"~nvim"'
          set -g @resurrect-save-zsh-history 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '5'
        '';
      }
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

      set -g status-position top
    '';
  };
}
