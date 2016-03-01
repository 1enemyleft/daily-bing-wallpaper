# daily-bing-wallpaper
This application set bing wallpaper daily when the computer wakes up 

# Prerequisites
install homebrew http://brew.sh/
## wget 
brew install wget
## sleepwatcher 
brew install sleepwatcher

# Steps to use this script 
1. Save the shell script on your computer 
2. Save the following command in your applescript editor 
    check sleepwatcher path: which sleepwatcher
    do shell script "/usr/local/sbin/sleepwatcher -w /path/to/daily-bing-waller.sh &> /dev/null &"
3. Export the applescript to application 
