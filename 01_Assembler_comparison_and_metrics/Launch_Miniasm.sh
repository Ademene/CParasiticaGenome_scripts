#/!bin/bash

Minimap2='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/minimap2/minimap2'
miniasm='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/miniasm/miniasm'
ONTReads='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Misassemblies_verification/DUM005_good/BAMs_and_Reads_From_TE_region/DUM_TEs_ONT_reads_corrected_1_sp.fastq'
OUT='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Misassemblies_verification/DUM005_good/BAMs_and_Reads_From_TE_region/DUM005_TE_Region_assembly_miniasm_colormapCorrectedStep1'

$Minimap2 -ax ava-ont -t18 -k20 $ONTReads $ONTReads | gzip -1 > $OUT.paf.gz
$miniasm -f $ONTReads $OUT.paf.gz > $OUT.gfa 

