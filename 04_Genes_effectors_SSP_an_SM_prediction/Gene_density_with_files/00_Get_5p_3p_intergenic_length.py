# Script used to extract the intergenic lengths in 3' (from the stop) and 5' (from the start)
# Le fichier ne doit pas contenir de gènes ayant juste 1 start ou 1 stop...

# File needed : 

'''

Start_and_Stop.bed

Here /media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/13_Figures_finales/Gene_density_plot/ESM015_3_augustus.hints.simplified.onlyt1.startANDstop.sort.bed
 Format : 
 ESM_0	15231	15233	g2	start_codon
 ESM_0	15462	15464	g2	stop_codon 
 ...


'''

# Usage :

'''
python Get_5p_3p_intergenic_length.py Start_and_Stop.bed
'''

# Modules

import sys

### Script

# Inputs
input = sys.argv[1]
input2 = sys.argv[2]

Start_and_Stop = open(input,'r')


#

last_gene = "0"
last_chrom = 0
inter_len = {}
for line in Start_and_Stop:

    [chrom,start,stop,gene,codon] = line.strip().split()

    if chrom != last_chrom:
        #On est sur un nouveau chromosome
        last_stop = 0
        if codon == "start_codon": # 5'
            #inter_len[gene] = ["5", "3", int(start) - int(last_stop)] # donne la distance au début du chromosome
            inter_len[gene] = ["5", "3", "unknown"] # Si on pref on peut mettre unconnu car c'est possible que ce soit le premier gène
        else: # 3'
            #inter_len[gene] = ["3", "5", int(start) - int(last_stop)] # donne la distance au début du chromosome
            inter_len[gene] = ["5", "3", "unknown"] # Si on pref on peut mettre unconnu car c'est possible que ce soit le premier gène
        ## Récup là taille du crom
        Chrom_file = open(input2,'r')
        for lines in Chrom_file:
            [chrom_ref,end_ref] = lines.strip().split()
            #print(chrom,chrom_ref)
            if chrom == chrom_ref and last_gene != "0":
                #print("nouveau chrom")
                #inter_len[last_gene].append(int(end_ref) - int(last_stop)) # donne la distance à la fin de chrom
                inter_len[last_gene].append("unknown") # Si on pref on peut mettre unconnu car c'est possible que ce soit le dernier gène
            Last_chrom_size = lines.strip().split()[1]
        Chrom_file.close()


    else:

        if gene != last_gene : # C'est qu'on est plus dans le même gène, ça va servir à savoir si on doit aller chercher à gauche ou à droite du codon pour la région intergénique
            # Si on compte à gauche on compte à partir du start de la pos
            if codon == "start_codon": # 5'
                inter_len[gene] = ["5", "3", int(start) - int(last_stop)]
                #print("Intergenic length = " + str(inter_len) + " Les positions étaient {} et {}".format(start,last_pos))
            else: # 3'
                inter_len[gene] = ["3", "5", int(start) - int(last_stop)]
                #print("Intergenic length = " + str(inter_len) + " Les positions étaient {} et {}".format(start,last_pos))
            inter_len[last_gene].append(int(start) - int(last_stop))

    [last_chrom,last_start,last_stop,last_gene,last_codon] = line.strip().split()

## Ajout du dernier inter à la main: 

inter_len[last_gene].append("unknown")

## Write in new file

OUT = open("Intergenic.txt",'w')
OUT.write('gene\t5prim_intergenic_length\t3prim_intergenic_length\n')

for gene,inter in inter_len.items():
    inter = list(inter)
    #print(gene,inter)
    # We can remoove directly the lines with unknown intergenic length:
    if "unknown" not in inter:
        if inter[0] == '5':
            OUT.write(str(gene) + '\t' + str(inter[2]) + '\t' + str(inter[3]) + '\n')
        else:
            OUT.write(str(gene) + '\t' + str(inter[3]) + '\t' + str(inter[2]) + '\n')

# Close files 

Start_and_Stop.close()
OUT.close()
