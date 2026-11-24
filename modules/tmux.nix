{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.tmux;
  inherit (config) theme;

  sepR = builtins.fromJSON ''"\ue0b8"''; # solid, segment ends
  sepL = builtins.fromJSON ''"\ue0ba"''; # solid, segment starts (right side)
  sepThin = builtins.fromJSON ''"\ue0bb"''; # thin divider
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

        set -g status-style bg=default,fg=default
        set -g status-justify left
        set -g status-interval 30
        set -g status-left-length 40
        set -g status-right-length 120

        set -g status-left "#[fg=#${theme.base00},bg=#${theme.base0D},bold]   #S #[fg=#${theme.base03},bg=#${theme.base0D},nobold,noitalics,nounderscore]${sepL}#[fg=#${theme.base05},bg=#${theme.base03}]   #{session_windows} #[fg=#${theme.base00},bg=#${theme.base03}]${sepL}"       

        set -g status-right "#{prefix_highlight}#[fg=#${theme.base03},bg=default,nobold,noitalics,nounderscore]${sepL}#[fg=#${theme.base05},bg=#${theme.base03}] %Y-%m-%d #[fg=#${theme.base05},bg=#${theme.base03},nobold,noitalics,nounderscore]${sepThin}#[fg=#${theme.base05},bg=#${theme.base03}] %H:%M #[fg=#${theme.base0C},bg=#${theme.base03},nobold,noitalics,nounderscore]${sepL}#[fg=#${theme.base00},bg=#${theme.base0C},bold] 󰒋 #H "

        setw -g window-status-separator ""
        setw -g window-status-format "#[fg=#${theme.base04},bg=default] #I:#W "
        setw -g window-status-current-format "#[fg=#${theme.base02},bg=default,nobold,noitalics,nounderscore]${sepL}#[fg=#${theme.base0B},bg=#${theme.base02},bold] #I:#W #[fg=#${theme.base02},bg=default,nobold,noitalics,nounderscore]${sepR}"

        set -g pane-border-style "fg=#${theme.base02}"
        set -g pane-active-border-style "fg=#${theme.base0D}"
        set -g message-style "bg=#${theme.base02},fg=#${theme.base0D}"
        set -g message-command-style "bg=#${theme.base02},fg=#${theme.base0D}"
        setw -g clock-mode-colour "#${theme.base0D}"
        set -g display-panes-colour "#${theme.base04}"
        set -g display-panes-active-colour "#${theme.base0D}"
        set -g window-style 'bg=default'
        set -g window-active-style 'bg=default'
      '';
    };
  };
}
