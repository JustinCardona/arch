#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch example
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar left >>/tmp/polybar1.log 2>&1 &
polybar right >>/tmp/polybar2.log 2>&2 &

MONITOR=HDMI-0 polybar --reload left &
MONITOR=DP-0 polybar --reload right &

echo "Bars launched..."
