import sys
filein= sys.argv[1]

### Choose coverage (depth) line 16.

INPUT=open(filein,'r')
OUT=open(filein.replace('.bed','_undercovered.bed'),'w')

### header :

OUT.write("CHROM\tSTART\tSTOP\tCOVERAGE\tREGION_SIZE\n")

for lines in INPUT:
    cov=int(lines.split()[3])
    if cov == 0:
        inter=int(lines.split()[2])-int(lines.split()[1])
        OUT.write(lines.strip() + '\t' + str(inter) + '\n')

INPUT.close()
OUT.close()
