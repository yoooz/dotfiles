#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get CPU usage percentage using top
CPU=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print $3}' | cut -d'%' -f1)

# Round to integer
CPU_INT=${CPU%.*}

# Set color based on usage
if [ "$CPU_INT" -ge 80 ]; then
  COLOR=$HIGHLIGHT_DANGER
elif [ "$CPU_INT" -ge 50 ]; then
  COLOR=$HIGHLIGHT_WARN
else
  COLOR=$LABEL_COLOR
fi

# Push value to graph (0.0 - 1.0)
GRAPH_VALUE=$(echo "scale=2; $CPU_INT / 100" | bc)

sketchybar --set $NAME label="${CPU_INT}%" label.color=$COLOR \
  --push $NAME $GRAPH_VALUE
