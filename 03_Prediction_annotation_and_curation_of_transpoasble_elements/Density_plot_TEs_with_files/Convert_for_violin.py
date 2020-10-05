# -*- coding: utf-8 -*-
# Script used to adda last column with the minimal distance between the 5' and the 3' distance 
# Modules

import sys

### Script

# Inputs
input = sys.argv[1]

IN = open(input,'r')
OUT = open(input.replace('.families.txt','.families.closest.txt'),'w')

c = 0
for lines in IN:
    args = lines.strip().split()
    if c == 0:
        c += 1
        OUT.write("\t".join(args) + "\tMinimalDistance\n")
        continue
    elif int(args[1]) < int(args[2]):
        OUT.write("\t".join(args) + "\t" + args[1] + "\n")
    else:
        OUT.write("\t".join(args) + "\t" + args[2] + "\n")

IN.close()
OUT.close()
