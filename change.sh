#!/bin/bash
extractgst() {
	#source: https://wiki.archlinux.org/index.php/GDM#Log-in_screen_background_image
	workdir=${HOME}/shell-theme
	if [ ! -d ${workdir}/theme ]; then
		mkdir -p ${workdir}/theme/icons
	fi
	gst=/usr/share/gnome-shell/gnome-shell-theme.gresource

	for r in `gresource list $gst`; do
					gresource extract $gst $r >$workdir/${r#\/org\/gnome\/shell/}
	done
}

dir=$(dirname $0)
if [[ $# -eq 0 ]] ; then
	echo "please choose the picture you want to change"
	exit 0
fi

extractgst

filename=$(basename $1)
workdir=${HOME}/shell-theme/theme
cp $dir/gnome-shell-theme.gresource.xml $workdir/
cp $1 $workdir
cd $workdir
sed -i "s#filename#$filename#g" gnome-shell-theme.gresource.xml
sed -i "/#lockDialogGroup/,/^$/s#url(.*)#url($filename)#g" gnome-shell.css
sed -i "/#lockDialogGroup/,/^$/s#\ repeat#\ no-repeat#g" gnome-shell.css
glib-compile-resources gnome-shell-theme.gresource.xml
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell
