_: {
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
      reload = "source ~/.zshrc";
      mkdir = "mkdir -p";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    sessionVariables = {
      TERM = "xterm-256color";
      PNPM_HOME = "$HOME/.local/share/pnpm";
    };

    initContent = ''
      # FNM setup
      FNM_PATH="$HOME/.local/share/fnm"
      if [ -d "$FNM_PATH" ]; then
        export PATH="$FNM_PATH:$PATH"
        eval "$(fnm env)"
      fi

      # PNPM path
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # Direnv hook
      eval "$(direnv hook zsh)"

      if [[ -z "$TMUX_RESURRECT_RESTORE" ]]; then
        eval "$(direnv hook zsh)"
      fi

      # Tmux session switcher function
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

      # Vault auto-sync and backup
      autoload -Uz add-zsh-hook
      VAULT_DIR="$HOME/doc"

      chpwd_vault_pull() {
        if [[ "$PWD" == ''${VAULT_DIR}(|/*) ]]; then
          echo "Entered vault: syncing latest changes..."
          git -C "$VAULT_DIR" pull --ff-only || echo "⚠️ Git pull failed — check your network or branch."
        fi
      }

      chpwd_note_commit() {
        if [[ "$OLDPWD" == ''${VAULT_DIR}(|/*) && "$PWD" != ''${VAULT_DIR}(|/*) ]]; then
          if [[ -n "$(git -C "$VAULT_DIR" status --porcelain 2>/dev/null)" ]]; then
            echo "Leaving vault: committing changes..."
            "$HOME/bin/note-commit"
          else
            echo "Leaving vault: no changes to commit."
          fi
        fi
      }

      add-zsh-hook chpwd chpwd_vault_pull
      add-zsh-hook chpwd chpwd_note_commit
    '';
  };
}
