#/!bin/bash

cd /media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/SPAdes-3.13.0-Linux/bin

## Illumina read already corrected with BayesHammer or not? If yes, specify the reads and put : --only-assemble 
IlluminaR1="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Illumina_corrected/DUM005/Reads_clean/DUM005_TTCCTGTT-AAGATACT-AH72H2BBXY_L006__clean_1.fastq"
IlluminaR2="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Illumina_corrected/DUM005/Reads_clean/DUM005_TTCCTGTT-AAGATACT-AH72H2BBXY_L006__clean_2.fastq"

Nanopore="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Nanopore/DUM005/Dum005.Q10.minLength10kv.CovMax80.fastq"
#Assembly="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/4_Genomes/ESM015X_GoodNames_Final_cut_Scaffolded_ordered.fasta"
Output="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Spades_npScarf/DUM005_BestreadsQ10_10kb_cutoff_sansTrustedcontigs"

  ./spades.py -t 18 -k 127 --careful --mismatch-correction --cov-cutoff auto --pe1-1 ${IlluminaR1} --pe1-2 ${IlluminaR2} \
    --nanopore ${Nanopore} \
    -o ${Output}



## Choose kmer size : 
#     ./spades.py -k 21,33,55,77 
