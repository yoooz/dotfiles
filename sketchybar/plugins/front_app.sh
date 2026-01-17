#!/bin/bash

source "$CONFIG_DIR/icons.sh"

# Map app name to icon
get_app_icon() {
  case "$1" in
  "Terminal" | "iTerm2" | "Alacritty" | "kitty" | "WezTerm" | "Ghostty")
    echo "$ICON_TERMINAL"
    ;;
  "Safari" | "Google Chrome" | "Firefox" | "Arc" | "Brave Browser" | "Microsoft Edge")
    echo "$ICON_BROWSER"
    ;;
  "Code" | "Visual Studio Code" | "Cursor" | "Zed")
    echo "$ICON_CODE"
    ;;
  "Finder")
    echo "$ICON_FINDER"
    ;;
  "Mail" | "Spark" | "Airmail")
    echo "$ICON_MAIL"
    ;;
  "Music" | "Spotify")
    echo "$ICON_MUSIC"
    ;;
  "Slack")
    echo "$ICON_SLACK"
    ;;
  "Discord")
    echo "$ICON_DISCORD"
    ;;
  *)
    echo "$ICON_APP_DEFAULT"
    ;;
  esac
}

if [ "$SENDER" = "front_app_switched" ]; then
  APP_NAME="$INFO"
  ICON=$(get_app_icon "$APP_NAME")
  sketchybar --set $NAME icon="$ICON" label=" $APP_NAME"
fi
