# Print the current working directory (trimmed to max length).
# NOTE The trimming code's stolen from the web. Courtesy to who ever wrote it.

# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

TMUX_POWERLINE_SEG_PWD_MAX_LEN_DEFAULT="40"

generate_segmentrc() {
	read -d '' rccontents  << EORC
# Maximum length of output.
export TMUX_POWERLINE_SEG_PWD_MAX_LEN="${TMUX_POWERLINE_SEG_PWD_MAX_LEN_DEFAULT}"
EORC
	echo "$rccontents"
}

__process_settings() {
	if [ -z "$TMUX_POWERLINE_SEG_PWD_MAX_LEN" ]; then
		export TMUX_POWERLINE_SEG_PWD_MAX_LEN="${TMUX_POWERLINE_SEG_PWD_MAX_LEN_DEFAULT}"
	fi
}

run_segment() {
	__process_settings
	# Truncate from the left.
	#tcwd=#{pane_current_path}
	tcwd=$(osqueryi --list --header=false "select network_name from wifi_status limit 1;")
	trunc_symbol="···"
	dir=${tcwd##*/}
	local max_len="$TMUX_POWERLINE_SEG_PWD_MAX_LEN"
	max_len=$(( ( max_len < ${#dir} ) ? ${#dir} : max_len ))
	ttcwd=${tcwd/#$HOME/\~}
	pwdoffset=$(( ${#ttcwd} - max_len ))
	if [ ${pwdoffset} -gt "0" ]; then
		ttcwd=${ttcwd:$pwdoffset:$max_len}
		ttcwd=${trunc_symbol}/${ttcwd#*/}
	fi
	echo "$ttcwd"

	return 0
}
