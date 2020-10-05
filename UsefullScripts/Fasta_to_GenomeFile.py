import sys
filein= sys.argv[1]

### Le fasta ne doit pas être wrapé à 80caractère, et avoir toute la séquence sur la même ligne pour chaque '>'

INPUT=open(filein,'r')
OUT=open(filein.replace('.fasta','.genome'),'w')

### Penser à modifier la taille de la fenêtre ci-dessous et dans le OUT :
Size=1000

OUT.write("chromosome,size\n")
for lines in INPUT:
    if lines.startswith('>'):
        Scaf=(lines[1:].strip())
        OUT.write(Scaf + ',')
    else:
        OUT.write(str(len(lines)) + '\n')
        
INPUT.close()
OUT.close()
