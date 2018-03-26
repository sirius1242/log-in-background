#!/bin/bash

dir=$(dirname $0)
if [[ $# -eq 0 ]] ; then
	echo "please choose the picture you want to change"
	exit 0
fi
$dir/extractgst.sh

filename=$(basename $1)
filedir=${HOME}/shell-theme/theme
cp $dir/gnome-shell-theme.gresource.xml $filedir/
cp $1 $filedir
cd $filedir
sed -i "s#filename#$filename#g" gnome-shell-theme.gresource.xml
sed -i "/#lockDialogGroup/,/^$/s#url(.*)#url($filename)#g" gnome-shell.css
sed -i "/#lockDialogGroup/,/^$/s#\ repeat#\ no-repeat#g" gnome-shell.css
glib-compile-resources gnome-shell-theme.gresource.xml
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell
