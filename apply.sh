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

echo "all"
f locations/all || exit 1

case "$(uname -s)" in
 Linux*)
	echo "linux"
	 f locations/linux || exit 1
    ;;
 MINGW64*)
	echo "mingw"
	f locations/mingw || exit 1
    ;;
 *)
	 echo "Unknown $(uname -s)"
    ;;
esac

if [ -e "/usr/bin/wslinfo" ]; then
	echo "wsl"
	f locations/wsl || exit 1
fi;
