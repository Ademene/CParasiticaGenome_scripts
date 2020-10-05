import sys

input=sys.argv[1]

IN=open(input,'r')
OUT=open(input.replace('.gff','.bed'),'w')

for line in IN:
    args=line.strip().split()
    name = args[8].split("=")[2]
### (For TEs)    if args[2]=='match':
### prochaine ligne vérifier si ce sont les bons arguments (chrom start end)
    OUT.write(args[0]+'\t'+args[3]+'\t'+args[4]+'\t'+name+'\n')

IN.close()
OUT.close()
