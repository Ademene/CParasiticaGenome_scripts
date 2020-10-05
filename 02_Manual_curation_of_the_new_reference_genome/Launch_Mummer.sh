#/!bin/bash

REF=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/4_Genomes/ESM015_3.fasta
GENOME=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/4_Genomes/Mitho_DUM_Velvet.fasta
PREFIX=Mito_DUM_velvet_vs_ESM_3

# Run nucmer :
nucmer -t 10 -c 60 -p $PREFIX $REF $GENOME
# Filter min identity 95% and min alignment len 5000bp
delta-filter -1 -i 95 -l 5000 $PREFIX.delta > ${PREFIX}_filtered.delta
# Run show-coords ( -T to tab delimited table)
show-coords -T -r -c -l ${PREFIX}_filtered.delta > ${PREFIX}_filtered.coords
