source "$HELPERS_DIR/utility.sh"

HELPERS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$HELPERS_DIR/plugin_functions.sh"

reload_tmux_environment() {
	$TMUX_BIN source-file $(_get_user_tmux_conf) >/dev/null 2>&1
}
