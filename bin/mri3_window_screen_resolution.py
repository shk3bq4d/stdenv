#!/usr/bin/env python3

import os
import sys
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3
from pprint import pprint, pformat


if len(sys.argv) > 1:
    window_id = int(sys.argv[1])
    winobject = mri3.get_root().find_by_window(int(window_id))
else:
    winobject = mri3.focused()
    window_id = winobject.window

print("{width}x{height}".format(**vars(mri3.get_output(winobject).rect)))
