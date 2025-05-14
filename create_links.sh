#!/usr/bin/env bash

BASENAME="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ -z "$HOME" ]
then
	exit 2
fi


for LINK in "$BASENAME"/*
do
	if [ "$LINK" == "$BASENAME/create_links.sh" ]
	then
		continue
	fi

	if [ ! -f $LINK ]
	then
		continue
	fi

	from="$LINK"
	to="$HOME/.$(basename "$LINK")"

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

for LINK in "$BASENAME/config"/*
do
	from="$LINK"
	to="$HOME/.config/$(basename "$LINK")"

	if [ ! -L "$to" ]
	then
		if [ -e "$to" ]
		then
			rm -ri "$to"
		fi

		echo "$from --> $to"
		ln -s "$from" "$to" 
	fi
done
