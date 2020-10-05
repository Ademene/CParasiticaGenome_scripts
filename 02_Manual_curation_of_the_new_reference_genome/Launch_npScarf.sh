#/!bin/bash

PathJapsa='/home/arthur/.usr/local/bin/'
Minimap2='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/3_MinIon/1_Assemblies/minimap2/minimap2'
Contigs='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Spades_npScarf/DUM005_BestreadsQ10_10kb_cutoff_sansTrustedcontigs/scaffolds.fasta'
ONTReads='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/00_Fastq_Nanopore/DUM005/Dum005.Q10.minLength10kv.CovMax80.fastq'
Prefix='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/1_Assemblage/Spades_npScarf/DUM005_BestreadsQ10_10kb_cutoff_sansTrustedcontigs/DUM005_cutoff_Q10_10kb_Scaffolded'

### Sort contigs
${PathJapsa}jsa.seq.sort -r -n --input ${Contigs} --output ${PathScaffolding}/${ContigsSorted}

### Index contigs

bwa index ${PathScaffolding}/${ContigsSorted}

### Scaffolding step using short read (bwa)

#bwa mem -t 16 -k11 -W20 -r10 -A1 -B1 -O1 -E1 -L0 -a -Y $Contigs ${ONTReads} | ${PathJapsa}jsa.np.npscarf -input - -format sam --minContig=1000 --support=10 --bwaThread=16 --maxRepeat=1000000 -seq $Contigs -prefix ${Prefix}

### Scaffolding step using long read (minimap2), used in this study.

$Minimap2 -ax map-ont -t18 -k20 $Contigs ${ONTReads} | ${PathJapsa}jsa.np.npscarf -input - -format sam --minContig=1000 --support=10 --bwaThread=16 --maxRepeat=1000000 -seq $Contigs -prefix ${Prefix}
