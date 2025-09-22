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

      export PATH=/home/blckhrt/.opencode/bin:$PATH
      export PATH="$HOME/.cargo/bin:$PATH"

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
        local session sessions fzf_output

        sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null || true)

        fzf_output=$(echo -e "$sessions" | fzf \
          --height 40% \
          --border \
          --inline-info \
          --prompt='Tmux session: ' \
          --print-query)

        [ -z "$fzf_output" ] && return 1

        session=$(echo "$fzf_output" | tail -n1)

        if ! tmux has-session -t "$session" 2>/dev/null; then
          tmux new-session -d -s "$session"
        fi

        if [[ -n "$TMUX" ]]; then
          tmux switch-client -t "$session"
        else
          tmux attach -t "$session"
        fi
      }
    '';
  };
}
