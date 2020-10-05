## Script à lancer à la suite de Get_5p_3p_intergenic_length.py
## Pour ajouter l'info des genes effecteurs ou non


# Usage :

'''
python Add_effector_info.py ESM015.effectors.faa
'''

# Modules

import sys

### Script

# Inputs
input = sys.argv[1]

## Recup les effectors
effectors =  open(input,'r')

genes = []
for lines in effectors:
    if lines.startswith(">"):
        gene = lines.strip().split()[0][1:-3]
        genes.append(gene)

Intergenic = open("Intergenic.txt",'r')
Intergenic_EF = open("Intergenic_EF.txt",'w')

for lines in Intergenic:
    args = lines.strip().split()
    if args[0] in genes:
        Intergenic_EF.write("\t".join(args) + "\tEFF\n")
    else:
        Intergenic_EF.write("\t".join(args) + "\tnotEFF\n")


Intergenic_EF.close()
Intergenic.close
effectors.close()
