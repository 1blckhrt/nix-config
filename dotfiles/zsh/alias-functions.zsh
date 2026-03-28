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

switch () {
	nh home switch /home/blckhrt/nix-config -c laptop && \
	/home/blckhrt/bin/nixgit.sh
}

switch-pc () {
	nh home switch /home/blckhrt/nix-config -c pc && \
	/home/blckhrt/bin/nixgit.sh
}
