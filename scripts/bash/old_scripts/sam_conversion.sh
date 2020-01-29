#!/bin/bash

HOME=/mnt
REF=$HOME/AlternariaReference/NL03003.fasta
MAP_F=$HOME/AlternariaMapped/*.sam

for file in $MAP_F;do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.sam}.bam
	echo $OUTPUT
	samtools view -S -b $file > $OUTPUT
done


	

