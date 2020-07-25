#!/usr/bin/env bash

for LINK in *
do
	if [ "$LINK" == "create_links.sh" ]
	then
		continue
	fi

	from="$PWD/$LINK"
	to="$HOME/.$LINK"

	if [ ! -L "$to" ]
	then
		if [ -e "$to" ]
		then
			rm -i "$to"
		fi

		echo "$from --> $to"
		ln -s "$from" "$to" 
	fi
done
