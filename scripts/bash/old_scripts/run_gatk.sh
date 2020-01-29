#!/bin/bash

#index reference
HOME=/mnt
REF=$HOME/AlternariaSolaniReferences/NL03003.fasta
NAME=$(basename "$REF")
NAME=${NAME%.fasta}
echo $NAME
java -jar /home/ubuntu/tools/picard/build/libs/picard.jar CreateSequenceDictionary R=$REF O=$NAME.dict

samtools faidx NL03003.fasta






#run gatk

HOME=/mnt
REF=$HOME/AlternariaSolaniReferences/NL03003.fasta
STRAIN=$HOME/Samples.Bam.and.vcf.files/sortedbams

for FILE in $STRAIN;do
	NAME=$(basename "$FILE")
	NAME=${NAME%.dedup.sorted.bam}
	echo $NAME
	gatk --java-options "-Xmx16G" HaplotypeCaller --ploidy 1 --max-alternate-alleles 6 --native-pair-hmm-threads 10 -R $REF -I $FILE -O $NAME.raw.vcf 
done
