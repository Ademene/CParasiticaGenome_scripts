import sys
filein= sys.argv[1]

INPUT=open(filein,'r')
OUT=open(filein.replace('.fasta','.GoodName.fasta'),'w')

for line in INPUT:
    if line.startswith(">"):
        OUT.write(line.strip().split('_')[0]+'_'+line.strip().split('_')[1]+'\n')
    else:
        OUT.write(line)
INPUT.close()
OUT.close
