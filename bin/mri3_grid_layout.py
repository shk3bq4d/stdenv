#!/usr/bin/env python3

import sys
import os
import re
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3

if __name__ == '__main__':

    arg = sys.argv[1:]
    c = r = None
    if len(arg) >= 2:
        if 'c' in arg[0].lower():
            c = int(re.sub('\D+', '', arg[0]))
            r = int(re.sub('\D+', '', arg[1]))
        elif 'r' in arg[0].lower():
            r = int(re.sub('\D+', '', arg[0]))
            c = int(re.sub('\D+', '', arg[1]))
        elif 'c' in arg[1].lower():
            r = int(re.sub('\D+', '', arg[0]))
            c = int(re.sub('\D+', '', arg[1]))
        elif 'r' in arg[1].lower():
            c = int(re.sub('\D+', '', arg[0]))
            r = int(re.sub('\D+', '', arg[1]))
        else:
            c = int(re.sub('\D+', '', arg[0]))
            r = int(re.sub('\D+', '', arg[1]))
    elif len(arg) == 1:
        if 'c' in arg[0].lower():
            c = int(re.sub('\D+', '', arg[0]))
        elif 'r' in arg[0].lower():
            r = int(re.sub('\D+', '', arg[0]))
        else:
            c = int(re.sub('\D+', '', arg[0]))
    mri3.grid_layout(c, r)
