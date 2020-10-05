#/!bin/bash

###usage: ra [-h] [-u] [-t THREADS] [--version] -x {ont,pb}
###          sequences [ngs_sequences]

ra=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/ra/build/bin/ra 
ONT=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Nanopore/DUM005/Dum005.fastq
ILLR1=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Illumina_corrected/DUM005/Reads_clean/DUM005_TTCCTGTT-AAGATACT-AH72H2BBXY_L006__clean_1.fastq
OUT=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Ra/DUM005/DUM005.assemblyRA.fasta

###With illumina and ONT : 

$ra -t 18 -x ont $ONT $ILLR1 > $OUT

###Only ONT : 

#$ra -t 16 -x ont $ONT > $OUT
