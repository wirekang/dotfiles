#!/bin/bash

cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" || exit

function f() {
	SRC=0
	for LINE in $(cat "$1")
	do
		if [[ "$SRC" = 0 ]]; then
			SRC="$LINE"
		else
			eval cp "$SRC" "$LINE"
			SRC=0
		fi
	done
}

case "$(uname -s)" in
 Linux*)
	 f locations/all || exit 1
	 f locations/linux || exit 1
    ;;
 MINGW64*)
	 f locations/all || exit 1
	 f locations/mingw || exit 1
    ;;
 *)
	 echo "Unknown $(uname -s)"
    ;;
esac

