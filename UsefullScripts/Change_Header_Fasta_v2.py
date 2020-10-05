# -*- coding: utf-8 -*-

import sys

input = sys.argv[1]

IN = open(input, 'r')
OUT = open('NewHeader.fa', 'w')

c=0
for line in IN:
    if line.startswith(">"):
        c += 1
        args = line.strip()
        OUT.write(args + str(c) + "\n")
    else:
        OUT.write(line)

IN.close()
OUT.close()
