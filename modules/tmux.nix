{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.tmux;
  inherit (config) theme;
in
{
  options.modules.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."tmux/tmux-base.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/tmux/tmux-base.conf";

    programs.tmux = {
      enable = true;
      prefix = "C-x";
      terminal = "tmux-256color";
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 1000000;
      mouse = true;
      keyMode = "vi";

      plugins = [
        # hacky workaround to fix mnw + this tmux plugin both using single quotes in launch arguments
        (pkgs.tmuxPlugins.tmux-session-manager.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            substituteInPlace save_session.sh \
              --replace-fail '== "nixos"' '!= "never"' \
              --replace-fail 'tail +8' 'tail +4'
          '';
        }))
      ];

      extraConfig = ''
        source-file ~/.config/tmux/tmux-base.conf

        set -g status-style "bg=#${theme.base01},fg=#${theme.base05}"
        set -g status-left-length 40
        set -g status-right-length 80
        set -g status-left "#[bg=#${theme.base0D},fg=#${theme.base00},bold] 󰨇  #S #[bg=#${theme.base01},fg=#${theme.base0D}]"
        set -g status-right "#[bg=#${theme.base01},fg=#${theme.base0D}]#[bg=#${theme.base0D},fg=#${theme.base00},bold]   #h "

        setw -g window-status-format "#[fg=#${theme.base04}] #I:#W "
        setw -g window-status-current-format "#[bg=#${theme.base02},fg=#${theme.base0B},bold] #I:#W "

        set -g pane-border-style "fg=#${theme.base02}"
        set -g pane-active-border-style "fg=#${theme.base0D}"
        set -g message-style "bg=#${theme.base02},fg=#${theme.base0D}"
        set -g message-command-style "bg=#${theme.base02},fg=#${theme.base0D}"
        setw -g clock-mode-colour "#${theme.base0D}"
        set -g display-panes-colour "#${theme.base04}"
        set -g display-panes-active-colour "#${theme.base0D}"
        set -g window-style 'bg=default'
        set -g window-active-style 'bg=default'
        set -g status-style 'bg=default'
      '';
    };
  };
}
