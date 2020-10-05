import sys
filein= sys.argv[1]

INPUT=open(filein,'r')
OUTPUT=open(filein.replace("hints.gff","simplified.gff"),'w')

for line in INPUT:
    args=line.strip().split()
    if line.startswith('#')==False and args[2]=="gene":
        OUTPUT.write('\n'+'\t'.join(args)+"_parental_hint:")
    elif line.startswith('#      P:   1 ('):
        OUTPUT.write(args[3])


INPUT.close()
OUTPUT.close()


### Juste comment j'ai écrit le script, ça met une ligne vide au début du fichier de sortie, la virer à la main si besoin, ou améliorer le script :) 
