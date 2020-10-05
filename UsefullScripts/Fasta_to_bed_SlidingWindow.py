import sys
filein= sys.argv[1]

### Le fasta ne doit pas être wrapé à 80caractère, et avoir toute la séquence sur la même ligne pour chaque '>'

INPUT=open(filein,'r')
OUT=open(filein.replace('.fasta','nonOverlapingWindow_1kbsize.bed'),'w')

### Penser à modifier la taille de la fenêtre ci-dessous et dans le OUT :
Size=1000

for lines in INPUT:
    if lines.startswith('>'):
        Scaf=(lines[1:].strip())
    else:
        #print(len(lines))
        N_inter=int((len(lines)/Size))
        #print(N_inter)
        reste=len(lines)-N_inter*Size
        #print(reste)
        for i in range(0,N_inter):
            OUT.write(Scaf + "\t" + str(i*Size+1) + "\t" + str((i+1)*Size) + "\n")
        OUT.write(Scaf + "\t" + str(N_inter*Size+1) + "\t" + str((N_inter)*Size+reste) + "\n")


INPUT.close()
OUT.close()
