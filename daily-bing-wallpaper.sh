#!/bin/bash

# prequisite
# 1.wget : brew install wget
# 2.sleepwatcher: brew install sleepwatcher
# do shell script "/usr/local/sbin/sleepwatcher -w /path/to/wake.sh &> /dev/null &"

# Define variables 
FileLocation="/Users/{YourDirectory}/Pictures/Bing"
cd $FileLocation

Date=`date +%Y-%m-%d`

# define download wallpaper function 
function getWallpaper() {
	/usr/local/bin/wget --output-document=bing.html bing.com
	rm ./$Date.jpg
	/usr/local/bin/wget --output-document=$Date.jpg `sed -n "s/^.*g_img *= *{ *url:'\([^']*\)'.*$/\1/p" < bing.html | sed 's/^&quot;\(.*\)&quot;$/\1/' | sed 's/^\/\(.*\)/http:\/\/www.bing.com\/\1/'`
	rm ./bing.html
}

# define set wallpaper function 
function setWallpaper() {
	# mac os
	sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$FileLocation/$Date.jpg'";
	killall Dock
}

# define ping bing.com function 

function checkConnection() {

	((count = 200))                            # Set maximum number to try.
	while [[ $count -ne 0 ]] ; do
	    ping -c 1 www.bing.com                 # Try once.
	    successFlag=$?                         # if successFlag = 0 then success if 1 then unsuccess 
	    if [[ $successFlag -eq 0 ]] ; then
	        ((count = 1))                      # If okay, flag to exit loop.
	    fi
	    ((count = count - 1))                  # So we don't go forever.
	done

	return $successFlag 		           #return variable 
}

# sleep 60                                         # sunsetting this sleeping method 

# check if the connection is success 
checkConnection

if [[ $successFlag -eq 0 ]] ; then                  # Make final determination.
    echo "The connection is successful."

    # if successful then do the following
	# check if file exist
	if [ -f $FileLocation/$Date.jpg ]; then
	    # if exist exit
		echo "File exists, exiting script"
		exit
	else 
		echo "Downloading new wallpaper"
		# get the wallpaper and execute
		getWallpaper
		setWallpaper
	fi

    # else not successful then standard output the following
else
    echo "Your internet connection is not established."
fi	
