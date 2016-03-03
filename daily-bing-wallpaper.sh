#!/bin/bash

# prequisite
# 1.wget : brew install wget
# 2.sleepwatcher: brew install sleepwatcher
# do shell script "/usr/local/sbin/sleepwatcher -w /path/to/wake.sh &> /dev/null &"

# Define variables 
FileLocation="/Users/{yourUserName}/Pictures/Bing"
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
	sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = FileLocation + '/$Date.jpg'";
	killall Dock
}

# check if file exist
if [ -f FileLocation + $Date.jpg ]; then
    # if exist exit
	echo "File exists, exiting script"
	exit
else 
	echo "Downloading new wallpaper"
	# get the wallpaper and execute
	getWallpaper
	setWallpaper
fi

