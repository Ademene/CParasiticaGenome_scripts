##########################################################
### !!! If you encounter this problem when running busco :
#Traceback (most recent call last):
#  File "scripts/run_BUSCO.py", line 26, in <module>
#    from pipebricks.PipeLogger import PipeLogger
#ModuleNotFoundError: No module named 'pipebricks'
##########################################################

### Install Busco as : 
# git clone https://gitlab.com/ezlab/busco.git
# cd busco
# python setup.py install --user
# mv config/config.ini.default config/config.ini
### Then modify the config.ini file to set the path of the dependencies...
# tblast : I did not find how to recover this dependency, fortunately it comes with geneious (found by doing 'locate tblastn'), I put :
# /home/arthur/.geneious10.2data/BLAST/bin/
# makeblastdb : I type 'locate makeblastdb', fortunately it comes with geneious : 
# /home/arthur/.geneious10.2data/BLAST/bin/
# hmmsearch : in my usr/bin
# /usr/bin/
# augustus / entraining an perl script : found them with 'locate augustus'; moi j'ai :
# /usr/local/bin/
# /usr/local/bin/
# /opt/augustus-3.3.2/scripts/
# /opt/augustus-3.3.2/scripts/
# /opt/augustus-3.3.2/scripts/
#### Last error: ERROR	The environment variable AUGUSTUS_CONFIG_PATH is not set
## It's pretty clear, wrong path (probably called by perl scripts). You should define the path before running busco: 
## Pour moi c'est : 

export AUGUSTUS_CONFIG_PATH=/opt/augustus-3.3.2/config

### Choose and download the database here : https://busco.ezlab.org/ in dataset
## Let's go !

BUSCO='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/3_Busco_verif/busco/scripts/run_BUSCO.py'
GENOME=/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/10_Article/0_Article_Assembly_ESM015/A_partager/Genomes/out_MRC_miniasm.fasta
OUT=out_MRC_Miniasm
LINEAGE='/media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/3_Busco_verif/ascomycota_odb9'

#cd /media/arthur/2d3b38bd-0114-4823-bee9-582327c7cbdf/Arthur/MINION/00_Methods_Article/3_Busco_verif/busco-master/scripts
python3 $BUSCO -i $GENOME -o $OUT -l $LINEAGE -m geno -f

