#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get app icon based on name
get_app_icon() {
  case "$1" in
    "Terminal"|"iTerm2"|"Alacritty"|"kitty"|"WezTerm"|"Ghostty")
      echo "$ICON_TERMINAL" ;;
    "Safari"|"Google Chrome"|"Firefox"|"Arc"|"Brave Browser"|"Microsoft Edge")
      echo "$ICON_BROWSER" ;;
    "Code"|"Visual Studio Code"|"Cursor"|"Zed")
      echo "$ICON_CODE" ;;
    "Finder")
      echo "$ICON_FINDER" ;;
    "Mail"|"Spark"|"Airmail")
      echo "$ICON_MAIL" ;;
    "Music"|"Spotify")
      echo "$ICON_MUSIC" ;;
    "Slack")
      echo "$ICON_SLACK" ;;
    "Discord")
      echo "$ICON_DISCORD" ;;
    *)
      echo "$ICON_APP_DEFAULT" ;;
  esac
}

# Get focused workspace
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

# Get all workspaces on focused monitor
WORKSPACES=$(aerospace list-workspaces --monitor focused 2>/dev/null)

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
      ICON=$(get_app_icon "$app")
      APP_ICONS="$APP_ICONS$ICON "
    fi
  done <<< "$WINDOWS"

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
      icon="$ws" \
      icon.color=$ICON_COLOR \
      icon.font="Hack Nerd Font:Bold:14.0" \
      icon.padding_left=8 \
      icon.padding_right=4 \
      label="$APP_ICONS" \
      label.font="Hack Nerd Font:Regular:14.0" \
      label.padding_right=8 \
      background.color=$BG_COLOR \
      background.border_color=$BORDER_COLOR \
      background.border_width=2 \
      background.corner_radius=5 \
      background.height=24 \
      background.drawing=on \
      click_script="aerospace workspace $ws"
done
