#!/usr/bin/env bash
# Toggle game mode: strip visuals for lower latency, reload to restore.

STATE_FILE="$HOME/.cache/hypr-gamemode"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hyprctl reload
    notify-send "Game mode" "Disabled — config reloaded"
else
    touch "$STATE_FILE"
    # These may fail on older Hyprland versions; failures are non-fatal
    hyprctl --batch "
        keyword general:gaps_in 0;
        keyword general:gaps_out 0;
        keyword general:border_size 0;
        keyword decoration:rounding 0;
        keyword decoration:blur:enabled false;
        keyword decoration:shadow:enabled false;
        keyword animations:enabled false
    " 2>/dev/null || true
    notify-send "Game mode" "Enabled — visuals disabled"
fi
