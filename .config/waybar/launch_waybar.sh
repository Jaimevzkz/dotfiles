#!/bin/bash

HOME_DIR=$(eval echo ~$USER)
WAYBAR_DIR="$HOME_DIR/.config/waybar"

CONFIG_BLUE="$WAYBAR_DIR/config"
STYLE_BLUE="$WAYBAR_DIR/style.css"
CONFIG_TEMPLATE="$WAYBAR_DIR/config.template"

# Run envsubst on the full path to create config
envsubst < "$CONFIG_TEMPLATE" > "$CONFIG_BLUE"

# Now run waybar with absolute config and style paths
waybar -c "$CONFIG_BLUE" -s "$STYLE_BLUE" & disown

