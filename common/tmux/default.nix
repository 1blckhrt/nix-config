{
  config,
  pkgs,
  lib,
  ...
}: let
  tmux2k = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux2k";
    version = "unstable-latest";
    src = pkgs.fetchFromGitHub {
      owner = "2kabhishek";
      repo = "tmux2k";
      rev = "master";
      sha256 = "6dx81ItJodYUoWtlbGqoc5MPRCqy2PLgqIJK9lrAJ30=";
    };
  };

  tmux-which-key = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-which-key";
    version = "2024-01-10";
    src = pkgs.fetchFromGitHub {
      owner = "alexwforsythe";
      repo = "tmux-which-key";
      rev = "master";
      sha256 = "1h830h9rz4d5pdr3ymmjjwaxg6sh9vi3fpsn0bh10yy0gaf6xcaz";
    };
    rtpFilePath = "plugin.sh.tmux";
  };

  whichKeyScript = "${pkgs.tmuxPlugins.tmux-which-key}/share/tmux-plugins/tmux-which-key/which-key.sh";
in {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-x";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux2k;
        extraConfig = ''
          set -g @tmux2k-theme "duo"
          run-shell "${tmux2k}/share/tmux-plugins/tmux2k/main.sh"
          set -g @tmux2k-left-plugins "session"
          set -g @tmux2k-right-plugins "time"
        '';
      }

      {
        plugin = tmux-which-key;
        extraConfig = ''
          set -g @tmux-which-key-xdg-enable 1
          set -g @tmux-which-key-disable-autobuild 1
        '';
      }

      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-processes 'vim nvim hx cat less more tail watch'
          set -g @resurrect-dir ~/.local/share/tmux/resurrect
          set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g' $(readlink -f ~/.local/share/tmux/resurrect/last)"
          set -g @resurrect-save 'S'
          set -g @resurrect-restore 'R'
          set -g @resurrect-save-bash-history 'on'
          set -g @resurrect-save-zsh-history 'on'
          set -g @resurrect-save-shell-history 'on'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      sensible
      tmux-fzf

      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '0.1'
          set -g @continuum-save-bash-history 'on'
          set -g @continuum-save-zsh-history 'on'
          set -g @continuum-save-shell-history 'on'
        '';
      }
    ];

    extraConfig = ''
      unbind C-b
      bind C-x send-prefix
      set -sg escape-time 0
      set -g history-limit 1000000

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      set -g @which-key-popup-time 0.01

      setw -g mode-keys vi
      bind d detach
      bind * list-clients
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key Space run-shell "${whichKeyScript}"

      set-option -g status-position top

      bind-key x kill-pane
      set -g detach-on-destroy off

    '';
  };

  # Create resurrect directory
  home.file.".local/share/tmux/resurrect/.keep".text = "";

  systemd.user.services.tmux = {
    Unit = {
      Description = "Tmux server with continuum auto-restore";
      After = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
    };

    Service = {
      Type = "forking";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "5s";
      WorkingDirectory = "%h";

      Environment = [
        "HOME=%h"
        "SHELL=${pkgs.zsh}/bin/zsh"
        "PATH=%h/.nix-profile/bin:${pkgs.tmux}/bin:${pkgs.git}/bin:${pkgs.fzf}/bin:${pkgs.sesh}/bin:/run/current-system/sw/bin"
      ];

      ExecStart = "${pkgs.tmux}/bin/tmux new-session -d -s main || true";
      ExecReload = "${pkgs.tmux}/bin/tmux source-file ~/.config/tmux/tmux.conf";
      ExecStop = "${pkgs.tmux}/bin/tmux kill-server";

      KillMode = "none";
      TimeoutStopSec = "30s";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
