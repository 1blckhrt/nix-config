{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    baseIndex = 1;
    prefix = "C-x";

    plugins = with pkgs.tmuxPlugins; [
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
      vim-tmux-navigator

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
          # Writable path for resurrect saves
          set -g @resurrect-dir "$HOME/.local/share/tmux/resurrect"

          # Capture full pane contents & some processes
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes 'nvim'

          # Post-save cleanup: remove nix-store paths for portability
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
          # Enable automatic saves & restore
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
          set -g @continuum-boot 'on'

          # Explicit debug logging path
          set -g @continuum-boot-options 'debug'
          set-environment -g TMUX_CONTINUUM_DEBUG_LOG "$HOME/.local/share/tmux/tmux-continuum-debug.log"
        '';
      }
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

      ##### Reload #####
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      ##### Writable plugin manager path #####
      set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.local/share/tmux/plugins"
    '';
  };

  # Optional: create symlink for out-of-store writable state
  home.file.".local/share/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/tmux";
}
