notify_fail() {
	local TITLE="$1"
	local MESSAGE="$2"
	notify-send -u critical "$TITLE" "$MESSAGE"
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

vault_backup() {
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		return 0
	fi

	local REPO_NAME
	REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
	[[ "$REPO_NAME" != "doc" ]] && return 0

	[[ -z "$(git status --porcelain)" ]] && return 0

	local DATE HOST COMMIT_MSG
	DATE=$(date "+%Y%m%d-%H%M%S")
	HOST=$(hostname -s)
	COMMIT_MSG="vault backup: ${DATE} - ${HOST}"

	git add -A || {
		notify_fail "Vault backup failed" "git add failed in doc repo"
		return 1
	}

	git commit -m "$COMMIT_MSG" >/dev/null || {
		notify_fail "Vault backup failed" "git commit failed in doc repo"
		return 1
	}

	git push >/dev/null || {
		notify_fail "Vault backup failed" "git push failed in doc repo"
		return 1
	}
}

autoload -Uz add-zsh-hook

DOC_REPO_NAME="doc"

on_chpwd_doc_sync() {
	local OLD_REPO NEW_REPO

	if [[ -n "$OLDPWD" ]] && git -C "$OLDPWD" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		OLD_REPO=$(basename "$(git -C "$OLDPWD" rev-parse --show-toplevel)")
	fi

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		NEW_REPO=$(basename "$(git rev-parse --show-toplevel)")
	fi

	# Leaving doc => backup
	if [[ "$OLD_REPO" == "$DOC_REPO_NAME" && "$NEW_REPO" != "$DOC_REPO_NAME" ]]; then
		(cd "$OLDPWD" && vault_backup)
	fi

	# Entering doc => pull
	if [[ "$OLD_REPO" != "$DOC_REPO_NAME" && "$NEW_REPO" == "$DOC_REPO_NAME" ]]; then
		git pull --ff-only
	fi
}

add-zsh-hook chpwd on_chpwd_doc_sync

switch () {
	nh home switch /home/blckhrt/dot -c laptop && \
	/home/blckhrt/bin/nixgit.sh
}

switch-pc () {
	nh home switch /home/blckhrt/dot -c pc && \
	/home/blckhrt/bin/nixgit.sh
}

switch-srv () {
	nh home switch /home/blckhrt/dot -c debian-server && \
	/home/blckhrt/bin/nixgit.sh
}
