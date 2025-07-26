#!/bin/bash

# Expand the tilde to the user's home directory
HOME_DIR=$(eval echo ~$USER)
WAYBAR_DIR=".config/waybar"

# Define your configurations
CONFIG_BLUE="$HOME_DIR/$WAYBAR_DIR/blue/config"
STYLE_BLUE="$HOME_DIR/$WAYBAR_DIR/blue/style.css"

CONFIG_CATTPUCCIN="$HOME_DIR/$WAYBAR_DIR/catppuccin/config"
STYLE_CATTPUCCIN="$HOME_DIR/$WAYBAR_DIR/catppuccin/style.css"

CONFIG_TYPECRAFT="$HOME_DIR/$WAYBAR_DIR/typecraft/config.jsonc"
STYLE_TYPECRAFT="$HOME_DIR/$WAYBAR_DIR/typecraft/style.css"

CONFIG_MINIM_BLUE="$HOME_DIR/$WAYBAR_DIR/minimalistic_blue/config.jsonc"
STYLE_MINIM_BLUE="$HOME_DIR/$WAYBAR_DIR/minimalistic_blue/style.css"

# Check if a config number is passed as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <config_number (1=Blue, 2=Catppuccin, 3=Typecraft, 4=Minimalistic blue)>"
    exit 1
fi

CONFIG_NUMBER="$1"

# Select the configuration based on the number
case $CONFIG_NUMBER in
    1)
        WAYBAR_CONFIG=$CONFIG_BLUE
        WAYBAR_STYLE=$STYLE_BLUE
        ;;
    2)
        WAYBAR_CONFIG=$CONFIG_CATTPUCCIN
        WAYBAR_STYLE=$STYLE_CATTPUCCIN
        ;;
    3)
        WAYBAR_CONFIG=$CONFIG_TYPECRAFT
        WAYBAR_STYLE=$STYLE_TYPECRAFT
        ;;
    4)
        WAYBAR_CONFIG=$CONFIG_MINIM_BLUE
        WAYBAR_STYLE=$STYLE_MINIM_BLUE
        ;;
    *)
        echo "Invalid configuration number. Please choose 1, 2, or 3."
        exit 1
        ;;
esac

# Launch Waybar with custom config and style
waybar -c "$WAYBAR_CONFIG" -s "$WAYBAR_STYLE" & disown

