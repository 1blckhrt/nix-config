{
  pkgs,
  config,
  ...
}: let
  nordColors = {
    nord0 = "#2E3440";
    nord1 = "#3B4252";
    nord2 = "#434C5E";
    nord3 = "#4C566A";
    nord4 = "#D8DEE9";
    nord5 = "#E5E9F0";
    nord6 = "#ECEFF4";
    nord7 = "#8FBCBB";
    nord8 = "#88C0D0";
    nord9 = "#81A1C1";
    nord10 = "#5E81AC";
    nord11 = "#BF616A";
    nord12 = "#D08770";
    nord13 = "#EBCB8B";
    nord14 = "#A3BE8C";
    nord15 = "#B48EAD";
  };
in {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    prefix = "C-x";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator

      {
        plugin = tmux-which-key;
        extraConfig = ''
          set -g @tmux-which-key-xdg-enable 1
          set -g @tmux-which-key-disable-autobuild 0
        '';
      }

      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-dir "$HOME/.local/share/tmux/resurrect"
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes 'nvim'

          set -g @resurrect-hook-post-save-all '
            target=$(readlink -f "$HOME/.local/share/tmux/resurrect/last")
            sed "s| --cmd .*-vim-pack-dir||g; \
                 s|/etc/profiles/per-user/$USER/bin/||g; \
                 s|/home/$USER/.nix-profile/bin/||g" "$target" | ${pkgs.moreutils}/bin/sponge "$target"
          '
        '';
      }

      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'debug'
          set-environment -g TMUX_CONTINUUM_DEBUG_LOG "$HOME/.local/share/tmux/tmux-continuum-debug.log"
        '';
      }
    ];

    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -as terminal-features ",xterm-256color:RGB"

      set -g set-clipboard on
      set -g detach-on-destroy off
      set -g escape-time 0
      set -g history-limit 1000000
      set -g mouse on
      set -g status-interval 3
      set -g allow-passthrough on
      set -g status-position top

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

      set -g status on
      set -g status-bg '${nordColors.nord0}'
      set -g status-fg '${nordColors.nord4}'
      set -g status-left-length 50
      set -g status-right-length 65
      set -g status-justify absolute-centre

      set -g status-left "#[fg=${nordColors.nord8},bg=${nordColors.nord0}]#[fg=${nordColors.nord1},bg=${nordColors.nord8},bold]  #S  #[fg=${nordColors.nord8},bg=${nordColors.nord0}]"

      setw -g window-status-format "#[align=absolute-centre]#[fg=${nordColors.nord3},bg=${nordColors.nord0}]#[fg=${nordColors.nord4},bg=${nordColors.nord3}]  #I:#W  #[fg=${nordColors.nord3},bg=${nordColors.nord0}]"

      setw -g window-status-current-format "#[align=absolute-centre]#[fg=${nordColors.nord8},bg=${nordColors.nord0}]#[fg=${nordColors.nord1},bg=${nordColors.nord8},bold]  #I:#W  #[fg=${nordColors.nord8},bg=${nordColors.nord0}]"

      set -g status-right "#[fg=${nordColors.nord9},bg=${nordColors.nord0}]#[fg=${nordColors.nord1},bg=${nordColors.nord9},bold]  %Y-%m-%d  %H:%M  #h  #[fg=${nordColors.nord9},bg=${nordColors.nord0}]"
    '';
  };

  home.file.".local/share/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/tmux";
}
