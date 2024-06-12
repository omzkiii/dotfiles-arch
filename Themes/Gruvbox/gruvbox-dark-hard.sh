#!/bin/bash
wal --theme ~/Themes/Gruvbox/pywal-gruvbox-dark-hard.json
gsettings set org.gnome.desktop.interface gtk-theme "oomox-gruvbox-dark-hard"  
gsettings set org.gnome.desktop.interface icon-theme "oomox-gruvbox-dark-hard"
gsettings set org.gnome.desktop.wm.preferences theme "oomox-gruvbox-dark-hard"
cp -f ~/.cache/wal/colors-waybar.css ~/.config/waybar/
zathura-pywal
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "~/Pictures/Wallpapers/wall.jpg"
hyprctl hyprpaper wallpaper "DP-1, ~/Pictures/Wallpapers/wall.jpg"
killall waybar && waybar&
# cp -f ~/.cache/wal/color.ini ~/.config/spicetify/Themes/text/
spicetify config current_theme text color_scheme Gruvbox
spicetify apply
~/.config/mako/update-colors.sh
swww img ~/Pictures/Wallpapers/wall.jpg --transition-type center
notify-send Gruvbox
