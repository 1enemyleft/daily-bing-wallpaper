#!/bin/bash

# prequisite
# 1.wget : brew install wget
# 2.sleepwatcher: brew install sleepwatcher
# do shell script "/usr/local/sbin/sleepwatcher -w /path/to/wake.sh &> /dev/null &"

# Define variables 
FileLocation="/Users/jduan/Pictures/Bing"
cd $FileLocation

Date=`date +%Y-%m-%d`

# define download wallpaper function 
function getWallpaper() {
	wget --output-document=bing.html bing.com
	rm ./$Date.jpg
	wget --output-document=$Date.jpg `sed -n "s/^.*g_img *= *{ *url:'\([^']*\)'.*$/\1/p" < bing.html | sed 's/^&quot;\(.*\)&quot;$/\1/' | sed 's/^\/\(.*\)/http:\/\/www.bing.com\/\1/'`
	rm ./bing.html
}

# define set wallpaper function 
function setWallpaper() {
	# mac os
	sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '/Users/jduan/Pictures/Bing/$Date.jpg'";
	killall Dock
}

# if on linux use below as setWallpaper
<<COMMENTLinux
# This could be used in Linux/Unix 
gsettings set org.gnome.desktop.background picture-uri 'file:///Users/jduan/Pictures/Bing/$Date.jpg'
echo "want to save the picture?"
read answer
if [ $answer == y ]
    then
        cp ~/$Date.jpg ~/Pictures/Wallpapers/"`date`"
    else
        exit
fi
exit
COMMENTLinux 

# check if file exist
if [ -f /Users/jduan/Pictures/Bing/$Date.jpg ]; then
    # if exist exit
    exit
else 
	# get the wallpaper and execute
	getWallpaper
	setWallpaper
fi

