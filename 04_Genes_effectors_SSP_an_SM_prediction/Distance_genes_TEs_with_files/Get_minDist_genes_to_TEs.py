# Script used to extract the minimal distance between genes to TEs
# Le fichier ne doit pas contenir de gènes ayant juste 1 start ou 1 stop...

# File needed : 

'''

Genes.bed

ESM_0	1	296	g1
ESM_0	15231	15464	g2

TEs.bed

ESM_0	1	774	ESM_0_RXX_LARD_onlyIntegrase1
ESM_0	809	1044	ESM_0_Gypsy_invader_from_XIM2


'''

# Usage :

'''
python Get_minDist_genes_to_TEs.py Start_and_Stop.bed TEs.bed
'''

# Modules

import sys

### Script

# Inputs
input = sys.argv[1]
input2 = sys.argv[2]

Start_and_Stop = open(input,'r')

dist = {}
for line in Start_and_Stop:
    [chrom,start,stop,gene] = line.strip().split()
    TE_file = open(input2, 'r')
    list_dist = []
    for lines in TE_file:
        [chrom_TE,start_TE,stop_TE,TE] = lines.strip().split()
        if chrom_TE == chrom: # Check if we are on the same Scaff/chrom
            dist_startgene_startTE = int(start) - int(start_TE)
            dist_startgene_stopTE = int(start) - int(stop_TE)
            dist_stopgene_startTE = int(stop) - int(start_TE)
            dist_stopgene_stopTE = int(stop) - int(start_TE)
            list_dist.append(abs(dist_startgene_startTE))
            list_dist.append(abs(dist_startgene_stopTE))
            list_dist.append(abs(dist_stopgene_startTE))
            list_dist.append(abs(dist_stopgene_stopTE))
            #print(list_dist)
            if dist_startgene_startTE > 0 and dist_startgene_stopTE < 0 or dist_stopgene_startTE > 0 and dist_stopgene_stopTE < 0 : # The gene is inside a TE. Set dist = 1 
                dist[gene] = 1
                break
            else:
                dist[gene] = min(list_dist)
    TE_file.close()

OUT = open("Min_Dist_Gene_to_TE.txt",'w')
OUT.write('gene\tdistance\n')

for gene,dist_TE in dist.items():
    if dist_TE == 0:
        OUT.write(str(gene) + "\t" + "1" + "\n")
    else:
        OUT.write(str(gene) + "\t" + str(dist_TE) + "\n")



Start_and_Stop.close()
OUT.close()
