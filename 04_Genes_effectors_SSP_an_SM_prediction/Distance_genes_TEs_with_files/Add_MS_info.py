## Script à lancer à la suite de Get_5p_3p_intergenic_length.py
## Pour ajouter l'info des genes effecteurs ou non


# Usage :

'''
python Add_effector_info.py Genes_MS.Brut.txt
'''

# Modules

import sys

### Script

# Inputs
input = sys.argv[1]

## Recup les effectors
MS =  open(input,'r')

genes = []
for lines in MS:
    if lines.startswith("g"):
        gene = lines.strip().split()[0][:-3]
        genes.append(gene)

Intergenic = open("Min_Dist_Gene_to_TE_EF_SP.txt",'r')
Intergenic_MS = open("Min_Dist_Gene_to_TE_EF_SP_MS.txt",'w')

for lines in Intergenic:
    args = lines.strip().split()
    if args[0] in genes:
        Intergenic_MS.write("\t".join(args) + "\tMS\n")
    else:
        Intergenic_MS.write("\t".join(args) + "\tnotMS\n")


Intergenic_MS.close()
Intergenic.close
MS.close()
