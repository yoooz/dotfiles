#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get memory usage using memory_pressure
MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | cut -d'%' -f1)

# Calculate used percentage
if [ -n "$MEMORY_PRESSURE" ]; then
  MEM_USED=$((100 - MEMORY_PRESSURE))
else
  # Fallback: use vm_stat
  PAGE_SIZE=$(pagesize)
  PAGES_ACTIVE=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
  PAGES_WIRED=$(vm_stat | grep "Pages wired" | awk '{print $4}' | tr -d '.')
  PAGES_COMPRESSED=$(vm_stat | grep "Pages occupied by compressor" | awk '{print $5}' | tr -d '.')
  TOTAL_MEM=$(sysctl -n hw.memsize)

  USED_BYTES=$(((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED) * PAGE_SIZE))
  MEM_USED=$((USED_BYTES * 100 / TOTAL_MEM))
fi

# Set color based on usage
if [ "$MEM_USED" -ge 80 ]; then
  COLOR=$HIGHLIGHT_DANGER
elif [ "$MEM_USED" -ge 60 ]; then
  COLOR=$HIGHLIGHT_WARN
else
  COLOR=$LABEL_COLOR
fi

# Push value to graph (0.0 - 1.0)
GRAPH_VALUE=$(echo "scale=2; $MEM_USED / 100" | bc)

sketchybar --set $NAME label="${MEM_USED}%" label.color=$COLOR \
  --push $NAME $GRAPH_VALUE
