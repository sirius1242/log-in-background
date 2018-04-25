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

xml='
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource prefix="/org/gnome/shell/theme">
    <file>calendar-arrow-left.svg</file>
    <file>calendar-arrow-right.svg</file>
    <file>calendar-today.svg</file>
    <file>checkbox-focused.svg</file>
    <file>checkbox-off-focused.svg</file>
    <file>checkbox-off.svg</file>
    <file>checkbox.svg</file>
    <file>close-window-active.svg</file>
    <file>close-window-hover.svg</file>
    <file>close-window.svg</file>
    <file>close.svg</file>
    <file>corner-ripple-ltr.png</file>
    <file>corner-ripple-rtl.png</file>
    <file>dash-placeholder.svg</file>
    <file>filter-selected-ltr.svg</file>
    <file>filter-selected-rtl.svg</file>
    <file>gnome-shell-high-contrast.css</file>
    <file>gnome-shell.css</file>
    <file>icons/message-indicator-symbolic.svg</file>
    <file>logged-in-indicator.svg</file>
    <file>no-events.svg</file>
    <file>no-notifications.svg</file>
    <file>filename</file>
    <file>pad-osd.css</file>
    <file>page-indicator-active.svg</file>
    <file>page-indicator-checked.svg</file>
    <file>page-indicator-hover.svg</file>
    <file>page-indicator-inactive.svg</file>
    <file>process-working.svg</file>
    <file>running-indicator.svg</file>
    <file>source-button-border.svg</file>
    <file>summary-counter.svg</file>
    <file>toggle-off-hc.svg</file>
    <file>toggle-off-intl.svg</file>
    <file>toggle-off-us.svg</file>
    <file>toggle-on-hc.svg</file>
    <file>toggle-on-intl.svg</file>
    <file>toggle-on-us.svg</file>
    <file>ws-switch-arrow-down.png</file>
    <file>ws-switch-arrow-up.png</file>
  </gresource>
</gresources>
'

dir=$(dirname $0)
if [[ $# -eq 0 ]] ; then
	echo "please choose the picture you want to change"
	exit 0
fi

extractgst

filename=$(basename $1)
workdir=${HOME}/shell-theme/theme
#cp $dir/gnome-shell-theme.gresource.xml $workdir/
echo "$xml" > $workdir/gnome-shell-theme.gresource.xml
cp $1 $workdir
cd $workdir
sed -i "s#filename#$filename#g" gnome-shell-theme.gresource.xml
sed -i "/#lockDialogGroup/,/^$/s#url(.*)#url($filename)#g" gnome-shell.css
sed -i "/#lockDialogGroup/,/^$/s#\ repeat#\ no-repeat#g" gnome-shell.css
glib-compile-resources gnome-shell-theme.gresource.xml
sudo cp gnome-shell-theme.gresource /usr/share/gnome-shell
