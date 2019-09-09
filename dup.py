#!/usr/bin/env python3

import os
import sys
import hashlib, shutil

src = sys.argv[1]
targ = sys.argv[2]
for path, dir, files in os.walk(src):
    for f in files:
        name = os.path.join(path, f)
        _hash = hashlib.sha1((open(name,'rb')).read()).hexdigest()
        pre = _hash[0:2]
        fold = os.path.join(targ, pre)
        dest = os.path.join(fold, _hash)
        if not os.path.isdir(fold):
            os.mkdir(fold)
        if os.path.exists(dest):
            print(dest + " exist!")
        else:
            shutil.copy2(name, dest)
        os.remove(name)
        os.link(dest, name)
