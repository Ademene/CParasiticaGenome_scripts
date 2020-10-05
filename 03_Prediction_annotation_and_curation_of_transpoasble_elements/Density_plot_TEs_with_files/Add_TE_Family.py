# -*- coding: utf-8 -*-
# Script used to add the family of TEs

# Modules

import sys

### Script

# Inputs
input = sys.argv[1]

IN = open(input,'r')
OUT = open(input.replace('.txt','.families.txt'),'w')


for lines in IN:
    args = lines.strip().split()
    TE = args[3]
    #print(TE)
    if TE[0] == "D":
        Family = "DNA\n"
    elif TE[0] == "R":
        Family = "RNA\n"
    elif TE == "Gypsy":
        Family = "Gypsy\n"
    elif TE[0] == "P":
        Family = "PotentialHostGene\n"
    elif TE[0] == "C":
        Family = "Crypt1\n"
    elif TE == "type_of_TEs":
        Family = "Family\n"
    else:
        print(lines)
    args.append(Family)
    #print(args)
    OUT.write('\t'.join(args))

IN.close()
OUT.close()
