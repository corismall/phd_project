#!/bin/bash

#index reference
HOME=/home/corinn/
REF=$HOME/Documents/A.solani_sequencedata_F19FTSEUHT0141/reference/Alt_ref/AlternariaSolaniReferences/NL03003.fasta
STRAINS=$HOME/Documents/A.solani_sequencedata_F19FTSEUHT0141/Alt_vcfs/*.filtered.vcf
echo $STRAINS

#for FILE in $STRAINS;do
#	echo $FILE
#	NAME ="$(basename "$FILE")"
#	NAME=${NAME%.filtered.vcf}
#	echo $NAME

java -jar /mnt/GenomeAnalysisTK-3.6-0-g89b7209/GenomeAnalysisTK.jar -T CombineGVCFs -R $REF --variant $Strains -o cohort.g.vcf
#done
