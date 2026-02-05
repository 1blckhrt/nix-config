{pkgs, ...}: let
  tmux2k = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux2k";
    version = "2025-12-20";
    src = pkgs.fetchFromGitHub {
      owner = "2KAbhishek";
      repo = "tmux2k";
      rev = "2f7a613793a982401d9233fa2755dc2f5a916219";
      sha256 = "sha256-xg6ka8FJsii/LetYE3Cp+9kIiAg8AbK39Wpe7YEVEK8";
    };
    rtpPath = "2k.tmux";
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
                   set -g @tmux2k-black        "#2e3440"  # nord0
                   set -g @tmux2k-gray         "#4c566a"  # nord3
                   set -g @tmux2k-white        "#eceff4"  # nord6

                   set -g @tmux2k-light-blue   "#8fbcbb"  # nord7
                   set -g @tmux2k-blue         "#88c0d0"  # nord8
                   set -g @tmux2k-dark-blue    "#5e81ac"  # nord10

                   set -g @tmux2k-light-green  "#a3be8c"  # nord14
                   set -g @tmux2k-green        "#a3be8c"
                   set -g @tmux2k-dark-green   "#8fbcbb"

                   set -g @tmux2k-light-orange "#d08770"  # nord12
                   set -g @tmux2k-orange       "#d08770"
                   set -g @tmux2k-dark-orange  "#bf616a"

                   set -g @tmux2k-light-pink   "#b48ead"  # nord15
                   set -g @tmux2k-pink         "#b48ead"
                   set -g @tmux2k-dark-pink    "#9a6fae"

                   set -g @tmux2k-light-purple "#b48ead"
                   set -g @tmux2k-purple       "#81a1c1"  # nord9
                   set -g @tmux2k-dark-purple  "#5e81ac"

                   set -g @tmux2k-light-red    "#bf616a"  # nord11
                   set -g @tmux2k-red          "#bf616a"
                   set -g @tmux2k-dark-red     "#a54a54"

                   set -g @tmux2k-light-yellow "#ebcb8b"  # nord13
                   set -g @tmux2k-yellow       "#ebcb8b"
                   set -g @tmux2k-dark-yellow  "#d9b66c"

                   set -g @tmux2k-text                 "#{@tmux2k-white}"
                   set -g @tmux2k-bg-main              "#{@tmux2k-black}"
                   set -g @tmux2k-bg-alt               "#3b4252"  # nord1

                   set -g @tmux2k-message-bg           "#{@tmux2k-dark-blue}"
                   set -g @tmux2k-message-fg           "#{@tmux2k-white}"

                   set -g @tmux2k-pane-active-border   "#{@tmux2k-blue}"
                   set -g @tmux2k-pane-active-border-bg "#{@tmux2k-black}"

                   set -g @tmux2k-pane-border          "#{@tmux2k-gray}"
                   set -g @tmux2k-pane-border-bg       "#{@tmux2k-black}"

                   set -g @tmux2k-prefix-highlight     "#{@tmux2k-yellow}"

          set -g @tmux2k-icons-only true
                   set -g @tmux2k-session-icon " #S"

                   set -g @tmux2k-left-plugins "session git cpu ram"
                   set -g @tmux2k-right-plugins "network cpu ram"

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
