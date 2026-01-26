#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get battery info using pmset
BATTERY_INFO=$(pmset -g batt)
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -o "[0-9]*%" | head -1 | tr -d '%')
CHARGING=$(echo "$BATTERY_INFO" | grep -c "AC Power")

# Select icon based on percentage and charging state
if [ "$CHARGING" -gt 0 ]; then
  ICON=$ICON_BATTERY_CHARGING
  COLOR=$GREEN
elif [ "$PERCENTAGE" -ge 80 ]; then
  ICON=$ICON_BATTERY_100
  COLOR=$LABEL_COLOR
elif [ "$PERCENTAGE" -ge 60 ]; then
  ICON=$ICON_BATTERY_75
  COLOR=$LABEL_COLOR
elif [ "$PERCENTAGE" -ge 40 ]; then
  ICON=$ICON_BATTERY_50
  COLOR=$LABEL_COLOR
elif [ "$PERCENTAGE" -ge 20 ]; then
  ICON=$ICON_BATTERY_25
  COLOR=$HIGHLIGHT_WARN
else
  ICON=$ICON_BATTERY_0
  COLOR=$HIGHLIGHT_DANGER
fi

sketchybar --set $NAME icon="$ICON" label=" ${PERCENTAGE}%" icon.color=$COLOR label.color=$COLOR
