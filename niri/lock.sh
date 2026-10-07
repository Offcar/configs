#!/bin/bash
TMP=$(mktemp --suffix=.png)
OUTPUT=$(niri msg --json focused-output | jq -r '.name')
grim -o "$OUTPUT" -s 0.5 - | magick png:- -blur 0x8 -fill black -colorize 50% "$TMP"
swaylock --image "$TMP" --scaling stretch
rm "$TMP"
