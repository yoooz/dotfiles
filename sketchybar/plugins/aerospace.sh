#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get focused workspace
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

# Get non-empty workspaces on focused monitor
WORKSPACES=$(aerospace list-workspaces --monitor focused --empty no 2>/dev/null)

if [ -z "$WORKSPACES" ]; then
  exit 0
fi

# Remove old workspace items
sketchybar --remove '/space\..*/' 2>/dev/null

# Add workspace items
for ws in $WORKSPACES; do
  # Get windows in this workspace
  WINDOWS=$(aerospace list-windows --workspace "$ws" --format '%{app-name}' 2>/dev/null)

  # Build app icons string
  APP_ICONS=""
  while IFS= read -r app; do
    if [ -n "$app" ]; then
      ICON=$app
      APP_ICONS="$APP_ICONS$ICON "
    fi
  done <<<"$WINDOWS"

  # Determine if focused
  if [ "$ws" = "$FOCUSED" ]; then
    BG_COLOR=$BACKGROUND_2
    BORDER_COLOR=$HIGHLIGHT
  else
    BG_COLOR=$BACKGROUND_1
    BORDER_COLOR=$TRANSPARENT
  fi

  sketchybar --add item "space.$ws" left \
    --set "space.$ws" \
    icon.drawing=off \
    label="$APP_ICONS" \
    label.font="Hack Nerd Font:Regular:14.0" \
    label.padding_left=8 \
    label.padding_right=8 \
    background.color=$BG_COLOR \
    background.border_color=$BORDER_COLOR \
    background.border_width=2 \
    background.corner_radius=5 \
    background.height=24 \
    background.drawing=on \
    click_script="aerospace workspace $ws"
done
