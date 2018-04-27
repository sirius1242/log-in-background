#!/bin/bash

text=`wget -O- cn.bing.com`
url=`echo $text | grep img={url index.html | sed -n 's#.*\(/az[^"]*\).*#\1#;p'`
echo $url
wget https://cn.bing.com/$url
