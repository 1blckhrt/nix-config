{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    baseIndex = 1;
    prefix = "C-x";
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = nord.overrideAttrs (old: {
          postInstall =
            (old.postInstall or "")
            + ''
              # Ensure the script has a proper bash shebang
              if ! head -n1 $out/share/tmux-plugins/nord/nord.tmux | grep -q '^#!/usr/bin/env bash'; then
                sed -i '1s|^#!.*|#!/usr/bin/env bash|; t; 1s|^|#!/usr/bin/env bash\n|' \
                  $out/share/tmux-plugins/nord/nord.tmux
              fi
            '';
        });
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
      set -g status-position top
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
