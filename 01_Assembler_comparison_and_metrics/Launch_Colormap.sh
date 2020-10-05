#/!bin/bash

### Run Colormap

Chemin_colormap="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/ESM015X/colormap"
Chemin="/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/Fastq_Illumina_corrected/ESM015"
Name="ESM015_ILLUMINA_"


${Chemin_colormap}/bin/fastUtils shuffle -1 ${Name}_clean_1.fastq -2 ${Name}_clean_2.fastq -o ${Chemin}/ESM015_ILL_R1R2_shuffled.fastq
cd ${Chemin_colormap}
bash runCorr.sh ${Chemin}/ALL_reads_ESM015X.fastq ${Chemin}/ESM015_ILL_R1R2_shuffled.fastq ESM015X_CorrectedLongreads ESM015X_corr 18
