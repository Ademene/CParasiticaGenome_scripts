# -*- coding: utf-8 -*-

import sys

input=sys.argv[1]

IN=open(input,'r')
OUT=open(input.replace('.fa','.RIP_signatures_v2.txt'),'w')


dict_RIP = {}
for line in IN:
    CpA = 0
    TpG = 0
    ApC = 0
    GpT = 0
    TpA = 0
    ApT = 0
    CpG = 0
    GpC = 0
    if line.startswith(">"):
        TEname = line.strip()[1:]
    else:
        # sliding windows within the sequence.
        for x in range(len(line)-1):
            if str(line[x] + line[x+1]) == "CA":
                CpA += 1 
            elif str(line[x] + line[x+1]) == "TG":
                TpG += 1 
            elif str(line[x] + line[x+1]) == "AC":
                ApC += 1 
            elif str(line[x] + line[x+1]) == "GT":
                GpT += 1 
            elif str(line[x] + line[x+1]) == "TA":
                TpA += 1 
            elif str(line[x] + line[x+1]) == "AT":
                ApT += 1 
            elif str(line[x] + line[x+1]) == "CG":
                CpG += 1  
            elif str(line[x] + line[x+1]) == "GC":
                GpC += 1 
    dict_RIP[TEname] = [CpA, TpG, ApC, GpT, TpA, ApT, CpG, GpC]
    

# Header if needed
#OUT.write("TEname\tCpA\tTpG\tApC\tGpT\tTpA\tApT\t(CpA + TpG)/(ApC + GpT)\t(TpA/ApT)\ttypeTE\n")

for name,dinuc in dict_RIP.items():
    try:
        indice1 = (dinuc[0] + dinuc[1])/(dinuc[2] + dinuc[3])
    except ZeroDivisionError:
        indice1 = "NA"
    try:
        indice2 = dinuc[4]/dinuc[5]
    except ZeroDivisionError:
        indice2 = "NA"
    try:
        indice3 = dinuc[6]/dinuc[7]
    except ZeroDivisionError:
        indice3 = "NA"
    OUT.write(name + "\t" + "\t".join(str(y) for y in dinuc) + "\t" + str(indice1) + "\t" + str(indice2) + "\t" + str(indice3) + "\t")
    if name.startswith("Gypsy"):
        OUT.write("Gypsy_invader\n")
    elif name.startswith("D"):
        OUT.write("DNA_TEs\n")
    elif name.startswith("R"):
        OUT.write("RNA_TEs\n")
    elif name.startswith("Crypt1"):
        OUT.write("Crypt1\n")
    elif name.startswith("Pot"):
        OUT.write("PotentialHostGene\n")


IN.close()
OUT.close()
