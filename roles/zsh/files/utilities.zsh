tailf() {
		((!$#)) && echo "No file provided to follow!" && return 1

		tail -f "$1"  |  bat --paging=never --style=numbers -l log
}