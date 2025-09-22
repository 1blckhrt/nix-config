{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "lsd";
      h = "history";
      ff = "fastfetch";
      c = "clear";
      x = "exit";
      cat = "bat -pp";
      tree = "lsd --tree";
      nv = "nvim .";
      reload = "source ~/.zshrc";
      mkdir = "mkdir -p";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    initContent = ''
      # Load system-manager PATH
      if [ -f /etc/profile.d/system-manager-path.sh ]; then
        source /etc/profile.d/system-manager-path.sh
      fi

      # tmux-sessionizer
      bindkey -s '^f' "$HOME/bin/tmux-sessionizer\n"

      # PATH exports
      export PATH=/home/blckhrt/.opencode/bin:$PATH
      export PATH="$HOME/.cargo/bin:$PATH"

      # fnm (Fast Node Manager)
      FNM_PATH="$HOME/.local/share/fnm"
      if [ -d "$FNM_PATH" ]; then
        export PATH="$FNM_PATH:$PATH"
        eval "$(fnm env)"
      fi

      export TERM=xterm-256color
      eval "$(direnv hook zsh)"

      # git push helper
      gpush() {
        git add .
        git status
        echo -n "Continue with commit and push? [y/N]: "
        read -r reply
        if [[ "$reply" != "y" && "$reply" != "Y" ]]; then
          echo "Aborted."
          return 1
        fi
        echo -n "Enter commit message: "
        read -r message
        git commit -am "$message"
        git push
      }

      # sesh integration with fzf
      function sesh-sessions() {
        {
          exec </dev/tty
          exec <&1
          local session
          session=$(sesh list -t -c | fzf --height 40% \
                                          --reverse \
                                          --border-label ' sesh ' \
                                          --border \
                                          --prompt '⚡  ')
          zle reset-prompt > /dev/null 2>&1 || true
          [[ -z "$session" ]] && return
          sesh connect $session
        }
      }

      zle -N sesh-sessions
      bindkey -M emacs '\es' sesh-sessions
      bindkey -M vicmd '\es' sesh-sessions
      bindkey -M viins '\es' sesh-sessions

      # theme and startup clear
      wallust theme Mono-White
      clear
    '';
  };
}
