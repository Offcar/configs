#!/bin/bash
MONITOR="eDP-1"

if hyprctl monitors | grep -q "$MONITOR"; then
    hyprctl eval 'hl.monitor({ output = "eDP-1", disabled = true, })'
    
else
    hyprctl eval 'hl.monitor({ output = "eDP-1", disabled = false, mode = "1920x1200@60.02600", position = "0x0", scale = 1 })'
fi

killall waybar
sleep 1
waybar &
