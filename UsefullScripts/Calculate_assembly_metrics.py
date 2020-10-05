import sys
filein= sys.argv[1]

INPUT=open(filein,'r')
OUT=open(filein.replace('.fasta','.metrics.txt'),'w')

### definition des variables
len_contig=0
len_tot=0
c=0
dict_contigs={}

### lecture du fasta
for lines in INPUT:
    if lines.startswith(">")==True:
        c+=1
        print("Taille_du_contig_(en_bp)_: " + str(len_contig) + "\n")
        OUT.write(str(len_contig) + "\n")
        len_tot+=len_contig
        len_contig=0
        print("Nom_du_contig_: " + lines[1:-1])
        OUT.write(lines[1:-1] + '\t')
    else:
        len_contig+=len(lines.strip())
        A=lines.strip().count('A')        
        T=lines.strip().count('T')
        C=lines.strip().count('C')
        G=lines.strip().count('G')
        GC=(G+C)*100/len_contig
        print(GC)
        OUT.write(str(GC)+"\t")
len_tot+=len_contig
print("Taille_du_contig_(en_bp)_: " + str(len_contig) + "\n")
print("Nombre_de_contigs_: " + str(c))
print("Taille_totale_assemblage_(en_bp)_: " + str(len_tot))
OUT.write(str(len_contig) + "\n")
OUT.write("Nombre_de_contigs_: " + str(c) + '\n')
OUT.write("Taille_totale_assemblage_(en_bp)_: " + str(len_tot) + '\n')

OUT.close()
INPUT.close()


