import sys
filein= sys.argv[1]

INPUT=open(filein,'r')
OUT=open(filein.replace('.tsv','.gff'),'w')

OUT.write('##gff-version 3\n')

for lines in INPUT:
    args=lines.strip().split()
    sens=args[-1]
    if sens == "reverse":
        OUT.write(args[0] + "\tAugustusMagnaporthe\t" + args[2] + "\t" + args[3] + "\t" + args[4] + "\t.\t-\t.\tID=" + args[1] + ";From=AugustusPredictionWithMagnaportheGeneProfiles\n")
    if sens == "forward":
        OUT.write(args[0] + "\tAugustusMagnaporthe\t" + args[2] + "\t" + args[3] + "\t" + args[4] + "\t.\t+\t.\tID=" + args[1] + ";From=AugustusPredictionWithMagnaportheGeneProfiles\n")

INPUT.close()
OUT.close()
