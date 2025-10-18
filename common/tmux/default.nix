{
  pkgs,
  config,
  ...
}: let
  tmux-nerd-font-window-name = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name.tmux";
    version = "unstable-2023-08-22";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "c2e62d394a290a32e1394a694581791b0e344f9a";
      sha256 = "stkhp95iLNxPy74Lo2SNes5j1AA4q/rgl+eLiZS81uA=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    prefix = "C-x";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = nord;
      }
      vim-tmux-navigator
      tmux-which-key
    ];
    extraConfig = ''
      ##### Colors & Terminal #####
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -as terminal-features ",xterm-256color:RGB"

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

      ##### Reload #####
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
    '';
  };
}
#{
#        plugin = resurrect;
#        extraConfig = ''
#          set -g @resurrect-strategy-nvim 'session'
#          set -g @resurrect-strategy-vim 'session'
#          set -g @resurrect-capture-pane-contents 'on'
#        '';
#      }
#      {
#        plugin = continuum;
#        extraConfig = ''
#          set -g @continuum-restore 'on'
#          set -g @continuum-save-interval '5'
#          set -g @continuum-boot 'on'
#          set -g @continuum-systemd-start-cmd 'new-session -d'
#        '';
#      }

