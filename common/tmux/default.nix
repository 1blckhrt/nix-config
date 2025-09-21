{
  config,
  pkgs,
  lib,
  ...
}: let
  tmuxWhichKey = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-which-key";
    version = "unstable-latest";
    src = pkgs.fetchFromGitHub {
      owner = "alexwforsythe";
      repo = "tmux-which-key";
      rev = "master";
      sha256 = "1h830h9rz4d5pdr3ymmjjwaxg6sh9vi3fpsn0bh10yy0gaf6xcaz";
    };
    rtpFilePath = "plugin.sh.tmux";
  };

  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin-tmux";
    version = "unstable-latest";
    src = pkgs.fetchFromGitHub {
      owner = "omerxx";
      repo = "catppuccin-tmux";
      rev = "main"; # for stability, pin to a commit hash
      sha256 = "0vgpa5m84wqcj9vbr4gvw8mnrgrfxi6la4kw609adcrf3yjbw3i2";
    };
  };
in {
  home.packages = [pkgs.tmux];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-x";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmuxWhichKey;
        extraConfig = ''
          set -g @tmux-which-key-xdg-enable 1
          set -g @which-key-popup-time 0.01
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-processes 'vim nvim hx cat less more tail watch'
          resurrect_dir=~/.local/share/tmux/resurrect
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g' $(readlink -f $resurrect_dir/last)"
          set -g @resurrect-save 'S'
          set -g @resurrect-restore 'R'
          set -g @resurrect-save-bash-history 'on'
          set -g @resurrect-save-zsh-history 'on'
          set -g @resurrect-save-shell-history 'on'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {plugin = sensible;}
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '0.5'
          set -g @continuum-save-bash-history 'on'
          set -g @continuum-save-zsh-history 'on'
          set -g @continuum-save-shell-history 'on'
        '';
      }
      {
        plugin = catppuccin-tmux;
        extraConfig = ''
          # Force monochrome Catppuccin overrides
          set -g @catppuccin_status_bg "black"
          set -g @catppuccin_status_fg "white"

          set -g @catppuccin_window_active_bg "white"
          set -g @catppuccin_window_active_fg "black"
          set -g @catppuccin_window_inactive_bg "black"
          set -g @catppuccin_window_inactive_fg "white"

          set -g @catppuccin_pane_border_fg "white"
          set -g @catppuccin_pane_active_border_fg "white"

          set -g message-style bg=black,fg=white

          # Status modules
          set -g @catppuccin_status_modules_right "directory date_time"
          set -g @catppuccin_status_modules_left "session"

          # Status content
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
    ];

    extraConfig = ''
      unbind C-b
      bind C-x send-prefix
      set -sg escape-time 0
      set -g history-limit 1000000

      # Vim-like pane navigation (smart with vim)
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      # Pane splitting
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Misc bindings
      bind d detach
      bind * list-clients

      # Status bar at top
      set-option -g status-position top

      # Vi mode
      setw -g mode-keys vi
    '';
  };

  systemd.user.services.tmux = {
    Unit = {
      Description = "Tmux default session";
      Documentation = "man:tmux(1)";
      After = ["graphical-session.target"];
      Requires = ["graphical-session.target"];
    };

    Service = {
      Type = "forking";
      ExecStart = "${pkgs.tmux}/bin/tmux new-session -d -s default && /home/blckhrt/.tmux/plugins/tmux-resurrect/scripts/restore.sh";
      RemainAfterExit = true;
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
