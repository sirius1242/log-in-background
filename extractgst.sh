#!/bin/sh
#source: https://wiki.archlinux.org/index.php/GDM#Log-in_screen_background_image

workdir=${HOME}/shell-theme
if [ ! -d ${workdir}/theme ]; then
  mkdir -p ${workdir}/theme/icons
fi
gst=/usr/share/gnome-shell/gnome-shell-theme.gresource

for r in `gresource list $gst`; do
        gresource extract $gst $r >$workdir/${r#\/org\/gnome\/shell/}
done
