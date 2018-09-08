#! Check script arguments.

check_arg_side() {
	local side="$1"		
	if ! [ "$side" ==  "left" -o "$side" == "right" -o "$side" == "pane" ]; then
		echo "Argument must be the side to handle {left, right, pane} and not \"${side}\"."
    	exit 1
	fi
}
