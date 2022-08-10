#!/bin/sh

# FZF selection plugin for CliFM
# Written by L. Abramovich

# License: GPL3

if [ -n "$1" ]; then
	if [ "$1" = "--help" ] || [ "$1" = "help" ]; then
		name="$(basename "$0")"
		printf "Usage: %s [CMD [ARGS]] [--help, help]
Without arguments, it prints the list of files in the current directory allowing \
the user to select one or more of them. At exit, selected files are send to CliFM's \
Selection Box.

If a command is passed (CMD), either internal to CliFM or external, the list of \
currently selected files is printed, allowing the user to mark one or more of \
them. At exit, marked files will be passed to CMD and executed by CliFM.

The %%f modifier can be used to specify the argument position in CMD for marked \
files. For example, the command '%s cp %%f mydir/' will copy all marked files to \
the directory mydir/. If %%f is not specified, marked files will be inserted at \
the end of CMD.\n" "$name" "$name"
		exit 0
	fi
fi

if ! [ "$(which fzf 2>/dev/null)" ]; then
	printf "CLiFM: fzf: Command not found\n" >&2
	exit 1
fi

TMPDIR="/tmp/clifm/$CLIFM_PROFILE"
TMPFILE="$TMPDIR/${CLIFM_PROFILE}.fzfsel"

! [ -d "$TMPDIR" ] && mkdir -p "$TMPDIR"

HELP="Usage:

Alt-h: Toggle this help screen

TAB, Alt-down: Toggle select down

Alt-up: Toggle select up

Alt-right: Select all files

Alt-left: Deselect all files

Alt-Enter: Invert selection

Enter: Confirm selection, exit, and send selected files to CliFM

Esc: Cancel and exit"

if [ "$(tput colors)" -eq 256 ]; then
	BORDERS="--border=left"
else
	BORDERS="--no-unicode"
fi

marksel_mode=0
cmd="$1"

if [ -n "$cmd" ]; then

	if ! [ -f "$CLIFM_SELFILE" ]; then
		printf "CliFM: There are no selected files\n" >&2
		exit 1
	fi

	int_cmds=" cd o open p pr prop r t tr trash mm mime bm bookmarks br bulk ac ad exp export pin jc jp bl le te "

	is_int=0

	if echo "$int_cmds" | grep -q " $cmd "; then
		is_int=1
	fi
#	for x in $int_cmds; do
#		if [ "$cmd" == "$x" ]; then
#			is_int=1
#			break
#		fi
#	done

	if [ "$is_int" -eq 0 ] && ! [ "$(which "$cmd" 2>/dev/null)" ]; then
		printf "CliFM: %s: Command not found\n" "$cmd" >&2
		exit 1
	fi

	marksel_mode=1
	# shellcheck disable=SC2012
	# shellcheck disable=SC2046
	ls --color=always --indicator=none $(cat "$CLIFM_SELFILE") | \
	fzf --multi --marker='*' --info=inline --keep-right \
		--color "prompt:6,fg+:reverse,marker:2:bold,pointer:6,header:7" \
		--bind "alt-down:toggle+down,insert:toggle+down" \
		--bind "alt-up:toggle+up" \
		--bind "alt-right:select-all,alt-left:deselect-all" \
		--bind "alt-h:toggle-preview" --preview-window=:wrap \
		--bind "alt-enter:toggle-all" --preview "printf %s \"$HELP\"" \
		--reverse "$BORDERS" --ansi --prompt "CliFM> " > "$TMPFILE"

else
	# shellcheck disable=SC2012
	ls -A --group-directories-first --color=always | \
	fzf --multi --marker='*' --info=inline \
		--color "prompt:6,fg+:reverse,marker:2:bold,pointer:6,header:7" \
		--bind "alt-down:toggle+down,insert:toggle+down" \
		--bind "alt-up:toggle+up" \
		--bind "alt-right:select-all,alt-left:deselect-all" \
		--bind "alt-h:toggle-preview" --preview-window=:wrap \
		--bind "alt-enter:toggle-all" --preview "printf %s \"$HELP\"" \
		--reverse "$BORDERS" --no-sort --ansi --prompt "CliFM> " > "$TMPFILE"
fi

args="$*"

if [ "$marksel_mode" -eq 1 ]; then
	files="$(tr '\n' ' ' < "$TMPFILE")"
	if echo "$args" | grep -q "%f"; then
		echo "$args" | sed "s|\%f|$files|g" > "$CLIFM_BUS"
	else
		printf "%s %s" "$(echo "$args" | sed 's/\n/ /g')" "$files" > "$CLIFM_BUS"
	fi
else
	# shellcheck disable=SC1007
	while ISF= read -r line; do
		printf "%s\n" "$PWD/$line" >> "$CLIFM_SELFILE"
	done < "$TMPFILE"
fi

if [ -z "$DISPLAY" ]; then
	clear
else
	tput rmcup
fi

rm -f -- "$TMPFILE" > /dev/null 2>&1

exit 0
