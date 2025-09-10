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

                  bindkey -s '^f' "$HOME/bin/tmux-sessionizer\n"
            export PATH=/home/blckhrt/.opencode/bin:$PATH
              export PATH="$HOME/.cargo/bin:$PATH"

                  # fnm
                  FNM_PATH="$HOME/.local/share/fnm"
                  if [ -d "$FNM_PATH" ]; then
                    export PATH="$FNM_PATH:$PATH"
                    eval "$(fnm env)"
                  fi

                  export TERM=xterm-256color
                  eval "$(direnv hook zsh)"

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

                  tmux-session() {
                    if [ -z "$1" ]; then
                    echo "Usage: tmux-session <session-name>"
                      return 1
                    fi
                    tmux new-session -d -s "$1"
                    tmux attach -t "$1"
                  }

      			wallust theme Mono-White
      			clear
    '';
  };
}
