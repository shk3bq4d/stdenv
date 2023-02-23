#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */

import datetime
import os
import sys
import unittest


class StrptimeTesterTest(unittest.TestCase):

    def test_hehe(self) -> None:
        out_format = '%Y.%m.%d %H:%M:%S'
        bA = [
            ["20230223T092433", "%Y%m%dT%H%M%S", "2023.02.23 09:24:33"],
            ["20230223U092433", "%Y%m%dU%H%M%S", "2023.02.23 09:24:33"],
            ]
        for _in, _format, expected in bA:
            self.assertEquals(datetime.datetime.strptime(_in, _format).strftime(out_format), expected)

if __name__ == '__main__':
    unittest.main()
