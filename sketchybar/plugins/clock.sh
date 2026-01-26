#!/bin/bash

# Format: MM/DD (Day) HH:MM
sketchybar --set $NAME label="$(date '+%Y/%m/%d (%A) [ %H:%M ]')"
