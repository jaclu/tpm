#
#  I use an env var TMUX_BIN to point at the current tmux, defined in my
#  tmux.conf, in order to pick the version matching the server running.
#  This is needed when checking backwards compatability with various versions.
#  If not found, it is set to whatever is in path, so should have no negative
#  impact. In all calls to tmux I use $TMUX_BIN instead in the rest of this
#  plugin.
#
[ -z "$TMUX_BIN" ] && TMUX_BIN="tmux"


ensure_tpm_path_exists() {
	mkdir -p "$(tpm_path)"
}

fail_helper() {
	local message="$1"
	echo "$message" >&2
	FAIL="true"
}

exit_value_helper() {
	if [ "$FAIL" == "true" ]; then
		exit 1
	else
		exit 0
	fi
}

set_long_tmux_display_time() {
	#
	#  Since tmux display is used to indicate progress, save original
	#  display-time and temporarily set it to 2 minutes.
	#  New messages will overwrite previous, so this is not blocking anything.
	#  It is just a random long time to ensure that the messages don't time-out.
	#
	#  Use this to restore the original display-time before exiting:
	#
	#   $TMUX_BIN set-option -g display-time "$org_display_time"
	#
	org_display_time="$($TMUX_BIN show-options -g display-time | awk '{print $2}')"
	$TMUX_BIN set-option -g display-time 120000
}
