import sys
filein= sys.argv[1]

INPUT=open(filein,'r')
OUTPUT=open(filein.replace(".coords",".forCirca.coords"),'w')

for line in INPUT:
    args=line.strip().split()
    if line.startswith('['):
        OUTPUT.write("[S1]	[E1]	[S2]	[E2]	[LEN 1]	[LEN 2]	[% IDY]	[LEN R]	[LEN Q]	[COV R]	[COV Q]	[ESM]	[DUM]"+ "\n")
    else:
        val=(float(args[6]))
        if val<float(90.00):
            OUTPUT.write(args[0]+"\t"+args[1]+"\t"+args[2]+"\t"+args[3]+"\t"+args[4]+"\t"+args[5]+"\t"+"<0.90"+"\t"+args[7]+"\t"+args[8]+"\t"+args[9]+"\t"+args[10]+"\t"+args[11]+"\t"+args[12]+"\n")
        elif val>float(95.00) and val<float(100):
            OUTPUT.write(args[0]+"\t"+args[1]+"\t"+args[2]+"\t"+args[3]+"\t"+args[4]+"\t"+args[5]+"\t"+"95<x<100"+"\t"+args[7]+"\t"+args[8]+"\t"+args[9]+"\t"+args[10]+"\t"+args[11]+"\t"+args[12]+"\n")
        elif val>float(90.00) and val<float(95.00):
            OUTPUT.write(args[0]+"\t"+args[1]+"\t"+args[2]+"\t"+args[3]+"\t"+args[4]+"\t"+args[5]+"\t"+"90<x<95"+"\t"+args[7]+"\t"+args[8]+"\t"+args[9]+"\t"+args[10]+"\t"+args[11]+"\t"+args[12]+"\n")
        elif val==float(100):
            OUTPUT.write(args[0]+"\t"+args[1]+"\t"+args[2]+"\t"+args[3]+"\t"+args[4]+"\t"+args[5]+"\t"+"100"+"\t"+args[7]+"\t"+args[8]+"\t"+args[9]+"\t"+args[10]+"\t"+args[11]+"\t"+args[12]+"\n")

INPUT.close()
OUTPUT.close()
