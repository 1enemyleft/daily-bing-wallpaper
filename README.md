# daily-bing-wallpaper
This application set bing wallpaper daily when the computer wakes up 

## Prerequisites
1. System: OS X EL Capitan Version 10.11.3
2. install homebrew http://brew.sh/
3. wget: brew install wget
4. sleepwatcher: brew install sleepwatcher

## Steps to use this script 
1. Save the shell script on your computer 
2. Save the following command in your applescript editor:
    1. check sleepwatcher path: which sleepwatcher
    2. do shell script "/usr/local/sbin/sleepwatcher -w /path/to/daily-bing-waller.sh &> /dev/null &"
3. Export the applescript to application 
