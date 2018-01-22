#!/usr/bin/zsh

if [[ $# -eq 0 ]] ; then
	echo "please choose the picture you want to change"
	exit 0
fi
./extractgst.sh

workdir=$(HOME)/shell-theme
filename="$(cd $(dirname $1); pwd)/$(basename $1)"
cp gnome-shell-theme-gresource.xml $workdir/
sed -i "s/filename/$filename/g" $workdir/gnome-shell-theme-gresource.xml
sed -i "/#lockDialogGroup/,/^$/s/url(.*)/$filename/g" $workdir/gnome-shell.css
sed -i "/#lockDialogGroup/,/^$/s/\ repeat/\ no-repeat/g" $workdir/gnome-shell.css
glib-compile-resources gnome-shell-theme.gresource.xml
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell
