#!/bin/bash

#workdir=~/bing-wallpaper
[[ -z $1 ]] && workdir="$HOME/bing-wallpaper/" || workdir=$1
site=cn.bing.com
cd $workdir
text=`wget -O- $site/`
# text=`wget -O- $site/?ensearch=1`
# above is for international bing
if [[ -z $text ]]; then
	notify-send "connecting to $site failed!"
fi
url=`echo $text | grep img={url | sed -n 's#.*\(/az/[^"]*\).*#\1#;p'`
filename=`echo $url | awk -F/ '{print $NF}'`
echo file:$site$url
if [[ -e $filename ]]; then
	notify-send "file exist!"
	echo "file exist!"
else
	wget -O $workdir$filename https://$site/$url
fi
