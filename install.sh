#!/bin/sh

cd "$(dirname "$0")"

find home -type f | sed 's|^home/||' | while read f; do
	repopath="home/$f"
	homepath="$HOME/$f"
	mkdir -p $(dirname $homepath)
	cp "$repopath" "$homepath"
done
