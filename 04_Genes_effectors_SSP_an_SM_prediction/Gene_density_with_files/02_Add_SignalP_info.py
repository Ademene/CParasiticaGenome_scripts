## Script à lancer à la suite de Get_5p_3p_intergenic_length.py
## Pour ajouter l'info des genes effecteurs ou non


# Usage :

'''
python Add_effector_info.py ESM015.SP.gff
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
    gene = lines.strip().split()[8][:-3]
    genes.append(gene)

Intergenic = open("Intergenic_EF.txt",'r')
Intergenic_SP = open("Intergenic_EF_SP.txt",'w')

for lines in Intergenic:
    args = lines.strip().split()
    if args[0] in genes:
        Intergenic_SP.write("\t".join(args) + "\tSP\n")
    else:
        Intergenic_SP.write("\t".join(args) + "\tnotSP\n")


Intergenic_SP.close()
Intergenic.close
effectors.close()
