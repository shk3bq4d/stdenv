#!/usr/bin/env python3

import sys
import os
try:
    import mri3
except:
    sys.path.append(os.path.expanduser('~/py'))
    import mri3

mri3.grid_layout()
