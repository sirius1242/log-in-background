import sys

if len(sys.argv) >= 2:
    _str = sys.argv[1]
else:
    _str = input()
print(''.join(format(ord(x), 'b') for x in _str))
