#!/usr/bin/env python3

import sys

if len(sys.argv) >= 2:
    try:
        fp = open(sys.argv[1], 'r')
        string = fp.readlines()
        _str = ''.join(string)
    except FileNotFoundError:
        _str = sys.argv[1]
else:
    _str = input()
print(''.join(format(ord(x), 'b') for x in _str))
