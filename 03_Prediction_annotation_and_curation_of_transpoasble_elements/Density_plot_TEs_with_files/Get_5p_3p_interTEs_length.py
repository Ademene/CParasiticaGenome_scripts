# -*- coding: utf-8 -*-
# Script used to extract the intergenic lengths in 3' (from the stop) and 5' (from the start)
# Le fichier ne doit pas contenir de gènes ayant juste 1 start ou 1 stop...

# File needed : 

'''

Start_and_Stop.bed

Here /media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Gene_density_plot/ESM015_3_augustus.hints.simplified.onlyt1.startANDstop.sort.bed
 Format : 
 ESM_0	15231	15233	TE_name
 ESM_0	15462	15464	TE_name
 ...

Chrom file : 

ESM_0	4527040
ESM_1	4975903
ESM_2	5381769
ESM_3	4799557
ESM_4	4077749
...
'''

# Usage :

'''
python Get_5p_3p_interTEs_length.py ESM_annotEP155_refTEs_match.sorted.bed ESM015_3.genome
Take the match file and not the match part file.
'''

# Modules

import sys

### Script

# Inputs
input = sys.argv[1]
input2 = sys.argv[2]

Start_and_Stop = open(input,'r')


#

last_TE = "0"
last_chrom = 0
inter_len = {}
for line in Start_and_Stop:
    #print(line)
    [chrom,start,stop,TE] = line.strip().split()

    if chrom != last_chrom:
        #On est sur un nouveau chromosome
        last_stop = 0
        inter_len[TE] = ["left", "right", "unknown"] # Si on pref on peut mettre unconnu car c'est possible que ce soit le premier gène
        ## Récup là taille du crom
        Chrom_file = open(input2,'r')
        for lines in Chrom_file:
            [chrom_ref,end_ref] = lines.strip().split()
            #print(chrom,chrom_ref)
            if chrom == chrom_ref and last_TE != "0":
                #print("nouveau chrom")
                #inter_len[last_gene].append(int(end_ref) - int(last_stop)) # donne la distance à la fin de chrom
                inter_len[last_TE].append("unknown") # Si on pref on peut mettre unconnu car c'est possible que ce soit le dernier gène
            Last_chrom_size = lines.strip().split()[1]
        Chrom_file.close()


    else:

        inter_len[TE] = ["left", "right", int(start) - int(last_stop)]
        inter_len[last_TE].append(int(start) - int(last_stop))

    [last_chrom,last_start,last_stop,last_TE] = line.strip().split()

## Ajout du dernier inter à la main: 

inter_len[TE].append("unknown")

## Write in new file

OUT = open("InterTEs.txt",'w')
OUT.write('TE\tleft_interTEs_length\tright_interTEs_length\n')

for TE, inter in inter_len.items():
    inter = list(inter)
    #print(gene,inter)
    # We can remoove directly the lines with unknown intergenic length:
    if "unknown" not in inter:
        if inter[2] < 0: ## If the inter_TE length is negative, they are overlapping so we put 1 as minimum value
            OUT.write(str(TE) + '\t1\t' + str(inter[3]) + '\n')
        elif inter[3] < 0: ## If the inter_TE length is negative, they are overlapping so we put 1 as minimum value
            OUT.write(str(TE) + '\t' + str(inter[2]) + '\t1\n')
        elif inter[2] < 0 and inter[3] < 0:  ## If the inter_TE length is negative, they are overlapping so we put 1 as minimum value
            OUT.write(str(TE) + '\t1\t1\n')
# Close files 

Start_and_Stop.close()
OUT.close()
