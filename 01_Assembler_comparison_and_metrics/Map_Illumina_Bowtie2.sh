#/!bin/bash

## Basic mapping of R1 R2 illumina reads using Bowtie2

## Variables

REF='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Misassemblies_verification/ESM015_2/ESM015_3.fasta'
REFINDEXED='ESM'
ILLUMINA1='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Illumina_corrected/ESM015/Corrected_by_BayesHammer/SM_Crypa-ESM015X-G1_LB_pe_LN_150_PI_400_DT_20151123_FM_fastq_ESM015X_GCCAAT_L006__clean_1.00.0_0.cor.fastq'
ILLUMINA2='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Illumina_corrected/ESM015/Corrected_by_BayesHammer/SM_Crypa-ESM015X-G1_LB_pe_LN_150_PI_400_DT_20151123_FM_fastq_ESM015X_GCCAAT_L006__clean_2.00.0_0.cor.fastq'
OUT='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Misassemblies_verification/DUM005/ILLUMINA_on_ESM'


# Create index of the fasta file
bowtie2-build $REF $REFINDEXED

# Basic mapping of the R1 R2 reads on the $REF indexed. Outpu £OUT.sam. -p 18 mean 18 threads are used
bowtie2 -x $REFINDEXED -p 18 -1 $ILLUMINA1 -2 $ILLUMINA2 -S $OUT.sam > Illumina_ESM.log

# Convert the .sam file into binary .bam file
samtools view -@ 18 -bS $OUT.sam > $OUT.bam

# Sort the .bam file
samtools sort -@ 18 $OUT.bam -o $OUT.sorted.bam

# Index the sorted.bam file. In order to read it with IGV for example
samtools index -@ 18 $OUT.sorted.bam

# Remove intermediate files
rm $OUT.sam
rm $OUT.bam
