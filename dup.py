#!/usr/bin/env python3

import os
import sys
import hashlib, shutil, stat, gc

src = sys.argv[1]
targ = sys.argv[2]
for path, dir, files in os.walk(src):
    print(path, flush=True)
    for f in files:
        name = os.path.join(path, f)
        try:
            if os.stat(name)[stat.ST_NLINK] >= 2 or not os.path.isfile(name):
                continue
            with open(name, 'rb') as fp:
                _hash = hashlib.sha1(fp.read()).hexdigest()
        except OSError:
            print("Error occured when open "+name+"!")
            continue
        pre = _hash[0:2]
        fold = os.path.join(targ, pre)
        dest = os.path.join(fold, _hash)
        if not os.path.isdir(fold):
            os.mkdir(fold)
        if os.path.exists(dest):
            print(dest + " exist!")
            os.remove(name)
            try:
                os.link(dest, name)
            except OSError:
                print("Error occured when link "+dest+" to "+name+"!")
        else:
            try:
                os.link(name, dest)
            except OSError:
                print("Error occured when link "+name+" to "+dest+"!")
        gc.collect()