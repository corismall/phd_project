#!/bin/bash

HOME=/mnt
REF=$HOME/AlternariaReference/NL03003.fasta
STRAIN=$HOME/AlternariaRawSeq/*/
ALN_F=$HOME/AlternariaMapped/


for folder in $STRAIN;do
	NAME=$(basename "$folder")
	echo $NAME
	echo $folder
	OUTPUT=aln_$NAME.sam
	echo $OUTPUT
	bwa mem -t 34 -R '@RG\tID:As_{$NAME}\tSM:As_{$NAME}' $REF $folder/*_1.fq.gz $folder/*_2.fq.gz > $OUTPUT
	mv $OUTPUT $ALN_F
done


