#!/bin/bash

src=$1
tar=$2
find $1 -type f | while read line;
do
    tmp=$(sha1sum "$line" | awk '{print $1}')
    pre=$(echo $tmp | awk '{print substr($0,0,2)}')
    if [ ! -d $2/$pre ]
    then
        mkdir $2/$pre
    fi
    if [ -e $2/$pre/$tmp ]
    then
        echo "$2/$pre/$tmp exist!"
    else
        cp "$line" $2/$pre/$tmp
    fi
done
