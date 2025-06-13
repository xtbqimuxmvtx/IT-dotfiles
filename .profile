# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

#export XDG_DATA_DIRS=$XDG_DATA_DIRS:/home/j/.local/share/wallpapers/
export WALLPAPER="$XDG_DATA_DIRS/wallpapers/Endeavour-dark.png"
export BROWSER=brave
export TERMINAL=qterminal

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH="$PATH:/home/j/.config/scripts"
xrandr --dpi 288
export QT_FONT_DPI=288
setfont Lat15-Terminus32x16
