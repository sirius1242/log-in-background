# Scripts
There will be some scripts I think may be useful in this repository, and new scripts will be added when I got useful ones
> ## [change.sh](./change.sh)
- An simple script to change log-in background of gnome in archlinux

- [Reference in archwiki](https://wiki.archlinux.org/index.php/GDM#Log-in_screen_background_image)

#### This change will be overwritten on subsequent updates of gnome-shell
    
### usage:
``` 
./change.sh path-of-image 
```
and after execute the script, tab Alt+F2 and enter 'restart'(in Xorg, and wayland do not apply restart without reboot)
> ## [str2bin.py](./str2bin.py)
- An simple python3 script to convert ascii character to 0,1 string

### usage
```sh
python str2bin.py string(or filename)
```
if use string as parameter, you will get the result of this string; if filename was used, you will get the result of the contents in file __filename__

or after execute `python str2bin.py`, type the string you want to convert.

you can also use `./str2bin.py`, and if default python of your system is not python3, please change the head of script to python3
> ## [curl.sh](./curl.sh)
- An simple shell script to get wallpaper of bing today
#### <span style="color:red"> **Caution! This script is based on string handling, extract the url begin with /az, so it may not always work properly**</span>

- [There is a python3 script and set it as wallpaper](https://github.com/mammuth/bing-wallpaper)
- [This is anthor shell achievement](https://github.com/whizzzkid/bing-wallpapers-for-linux)
### usage
```sh
./curl.sh workdir
```
if use workdir as parameter, you will download the wallpaper to `workdir`, if no workdir set, `workdir` set to `~/bing-wallpaper` as default (you can change this variable)

you can put it in cron, and execute it every reboot (`@reboot`) or use `if [[ -z $BING_WALLPAPER ]]; then ./curl.sh && export BING_WALLPAPER=1; fi` execute every certain time in crontab, and if executed successfully, it will not execute after one successful download in one reboot.