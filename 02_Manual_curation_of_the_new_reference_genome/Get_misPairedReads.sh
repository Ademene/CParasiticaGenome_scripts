#/!bin/bash

# Script used to get regions with mmis paired reads

# Variables

BAM=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/2_Sctructural_Variant_Detection/BAMs/ESM015_ILL_ESM015_SpadesScaffolded.sorted.bam
OUT=MisPaired_Reads_ESM015_Scaffolded
DEPTH_File=Coverage_MisPaired_Reads_ESM015_Scaffolded.depth


# Extract the mis paired reads == read-pairs wich mapped only by R1 or R2, or wich mapped R1 and R2 with an unexpectedly large insert
samtools view -@ 14 -F 14 -h -q 5 $BAM | grep -v " = " > $OUT.sam

# Sam to binary .bam
samtools view -@ 14 -b $OUT.sam > $OUT.bam

# index .bam file. File should be sorted if needed
samtools index $OUT.bam

# Get depth
samtools depth $OUT.bam > $DEPTH_File

# Bam to Bed
bamToBed -i $OUT.bam > $OUT.bed

# Sort regions
sort -k1,1 -k2,2n $OUT.bed > $OUT.sorted.bed

# Merge regions

bedtools merge -i $OUT.sorted.bed -c 1 -o count > $OUT.merged.bed

# Remove large sam file
rm $OUT.sam












