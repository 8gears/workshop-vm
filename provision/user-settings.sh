
# apply various user settings on every startup

# configuring 'us' and 'ch' keyboard layout
if [ "$(gsettings get org.gnome.desktop.input-sources sources)" == "@a(ss) []" ]; then
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ch')]"  2>/dev/null
fi

# disable lock-screen
gsettings set org.gnome.desktop.screensaver lock-enabled false  2>/dev/null
gsettings set org.gnome.desktop.screensaver lock-delay 0  2>/dev/null
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false  2>/dev/null
gsettings set org.gnome.desktop.screensaver user-switch-enabled false  2>/dev/null
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false  2>/dev/null
