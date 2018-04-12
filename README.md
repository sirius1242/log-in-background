# Scripts
There will be some scripts I think may be useful in this repository, and new scripts will be added when I got useful ones
> ## [change.sh](./change.sh)
- An simple script to change log-in background of gnome in archlinux

- [Reference in archwiki](https://wiki.archlinux.org/index.php/GDM#Log-in_screen_background_image)

#### This change will be overwritten on subsequent updates of gnome-shell
    
### usage:
``` 
./change.sh name-of-image 
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
