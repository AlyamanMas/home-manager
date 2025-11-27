#!/usr/bin/env sh

LOW_REFRESH_RATE_MODE="2880x1800@60.001"
HIGH_REFRESH_RATE_MODE="2880x1800@120.000"
OUTPUT_NAME="eDP-1"
INTERVAL=5

set_refresh_rate() {
	case "$1" in
	60)
		niri msg output $OUTPUT_NAME mode $LOW_REFRESH_RATE_MODE
		;;
	120)
		niri msg output $OUTPUT_NAME mode $HIGH_REFRESH_RATE_MODE
		;;
	esac
}

while true; do
	sleep $INTERVAL
	current_mode=$(powerprofilesctl get)
	case "$current_mode" in
	"performance")
		set_refresh_rate 120
		;;
	"balanced")
		set_refresh_rate 120
		;;
	"power-saver")
		set_refresh_rate 60
		;;
	esac
done
