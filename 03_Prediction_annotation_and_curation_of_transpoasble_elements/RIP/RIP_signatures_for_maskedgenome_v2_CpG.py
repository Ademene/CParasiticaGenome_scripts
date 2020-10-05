# -*- coding: utf-8 -*-

import sys

input=sys.argv[1]

IN=open(input,'r')
CpA = 0
TpG = 0
ApC = 0
GpT = 0
TpA = 0
ApT = 0
CpG = 0
GpC = 0

for line in IN:
    if line.startswith(">") == False:
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
    

indice1 = (CpA + TpG)/(ApC + GpT)
indice2 = TpA/ApT
indice3 = CpG/GpC

print("(CpA+TpG)/(ApC+GpT) = ", str(indice1))

print("(TpA)/(ApT) = ", str(indice2))

print("(CpG)/(GpC) = ", str(indice3))

IN.close()
