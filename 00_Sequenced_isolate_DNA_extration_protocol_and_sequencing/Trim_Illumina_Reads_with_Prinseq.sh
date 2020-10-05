#/!bin/bash

chemin_soft="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/ESM015X/ScriptBenoit_trimming_illumina"
Chemin="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/Fastq_Illumina_corrected/ESM015"
Chemin_sortie="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/Fastq_Illumina_corrected/ESM015/Reads_clean"
Name="ESM015_ILLUMINA_"



## If working on gziped files :
#gzip -d ${Chemin}/${Name}R1.fastq.gz
#gzip -d ${Chemin}/${Name}R2.fastq.gz

### Here the important options are trim left 5: to remove the first 5 nucleotides that on the fastqc shows variations in the base, probably due to adapter remnants; derep 14: to take out the exact duplicates
perl ${chemin_soft}/prinseq-lite.pl -fastq ${Chemin}/${Name}R1.fastq -fastq2 ${Chemin}/${Name}R2.fastq -trim_left 5 -out_format 3 -derep 14 -derep_min 2 -log log.${Name}.dedup.txt -out_good dedup.${Name} -out_bad null


### Here trim the 5' and 3' end bases (trim qual left/right 20) and averages (-trim_qual_type mean ) on a sliding window of 3 nucleotides (-trim_qual_window 3 ) and turns if less than 20 (trim qual left/right 20), advances by steps of 1 nucleotide (-trim_qual_step 1) until the average is above 20 and stops.
### Then there is a filter on the minimum size of the reads (-min_len 50), the maximum size (-max_len 280) and the average quality of the reads in its total length (-min_qual_mean 20). 

### I set the minimal quality of triplets to 28

perl ${chemin_soft}/prinseq-lite.pl -fastq dedup.${Name}_1.fastq -fastq2 dedup.${Name}_2.fastq -trim_qual_left 28 -trim_qual_right 28 -trim_qual_type mean -trim_qual_window 3 -trim_qual_step 1 -min_len 50 -max_len 280 -min_qual_mean 30 -out_format 3 -log log.${Name}.clean.txt -out_good ${Name}_clean -out_bad null 

## If working on gziped files :
#gzip ${Chemin}/${Name}R1.fastq.gz
#gzip ${Chemin}/${Name}R2.fastq.gz

