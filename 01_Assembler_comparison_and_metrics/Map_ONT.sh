#/!bin/bash

# Basic script to map ONT reads on a genome using Minimap2
# Here for Best hit, to adapt if needed


## Variables

Minimap2='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/minimap2/minimap2'
Fasta='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/4_Genomes/ESM015_3.fasta'
ONTReads='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Nanopore/DUM005/DUM005_NANOPORE_ALLREADS.fastq'
OUTDIR='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/2_Sctructural_Variant_Detection/BAMs/ESM_3/DUM005_ONT_on_ESM_3'

#Basic mapping, with 18 threads, adapted to ont reads, with kmer 20
$Minimap2 -ax map-ont -t18 -k20 $Fasta $ONTReads > $OUTDIR.sam

# Filter mapped reads to keep only best hits
samtools view -bS -F 256 -F4 -F 2048 -@ 18 $OUTDIR.sam > ${OUTDIR}_besthit.bam

# Sort the bam
samtools sort -@ 18 ${OUTDIR}_besthit.bam -o ${OUTDIR}_besthit.sorted.bam

# Index the bam
samtools index -@ 18 ${OUTDIR}_besthit.sorted.bam

# Remove intermediate files
rm $OUTDIR.sam
rm ${OUTDIR}_besthit.bam
