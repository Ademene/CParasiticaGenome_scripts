import sys
filein= sys.argv[1]

INPUT=open(filein,'r')

N=int(0)

for line in INPUT:
    if line.startswith('>')==False:
        N+=int(line.count('N'))
print("Nombre de Ns total : " + str(N))
INPUT.close()
