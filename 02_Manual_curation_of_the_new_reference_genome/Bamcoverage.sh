#/!bin/bash

bam=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Misassemblies_verification/ESM015_2/ONT_besthit.sorted.bam
out=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Misassemblies_verification/ESM015_2/Coverage.bw

bamCoverage --bam $bam -o $out \
    --binSize 10000
    --normalizeUsing RPGC
    --effectiveGenomeSize 43308684
    --numberOfProcessors 17
