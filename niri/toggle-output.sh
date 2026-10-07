#!/bin/bash
# Uso: toggle-output.sh <nombre-salida>
OUTPUT="${1:-eDP-1}"
if niri msg --json outputs | jq -e --arg o "$OUTPUT" '.[$o].current_mode != null' >/dev/null; then
    niri msg output "$OUTPUT" off
else
    niri msg output "$OUTPUT" on
fi
