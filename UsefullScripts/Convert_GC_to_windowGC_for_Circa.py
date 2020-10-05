import sys
filein= sys.argv[1]

INPUT=open(filein,'r')
OUTPUT=open(filein.replace(".csv",".forCirca.csv"),'w')

for line in INPUT:
    args=line.strip().split()
    val=(float(args[2]))
    if val<float(0.05):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0"+"\n")
    elif val>float(0.05) and val<float(0.1):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.05"+"\n")
    elif val>float(0.1) and val<float(0.15):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.1"+"\n")
    elif val>float(0.15) and val<float(0.2):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.15"+"\n")
    elif val>float(0.2) and val<float(0.25):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.2"+"\n")
    elif val>float(0.25) and val<float(0.3):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.25"+"\n")
    elif val>float(0.3) and val<float(0.35):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.3"+"\n")
    elif val>float(0.35) and val<float(0.4):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.35"+"\n")
    elif val>float(0.4) and val<float(0.45):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.4"+"\n")
    elif val>float(0.45) and val<float(0.5):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.45"+"\n")
    elif val>float(0.5) and val<float(0.55):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.5"+"\n")
    elif val>float(0.55) and val<float(0.6):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.55"+"\n")
    elif val>float(0.6) and val<float(0.65):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.6"+"\n")
    elif val>float(0.65) and val<float(0.7):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.65"+"\n")
    elif val>float(0.7) and val<float(0.75):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.7"+"\n")
    elif val>float(0.75) and val<float(0.8):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.75"+"\n")
    elif val>float(0.8) and val<float(0.85):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.8"+"\n")
    elif val>float(0.85) and val<float(0.9):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.85"+"\n")
    elif val>float(0.9) and val<float(0.95):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.9"+"\n")
    elif val>float(0.95) and val<float(1):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"0.95"+"\n")
    elif val==float(1):
        OUTPUT.write(args[0]+"\t"+args[1]+"\t"+"1"+"\n")

INPUT.close()
OUTPUT.close()
