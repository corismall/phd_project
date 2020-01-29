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

#sorting bam files
HOME=/mnt
MAP_B=$HOME/AlternariaMapped/*.bam

for file in $MAP_B;do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.bam}.sorted.bam
	echo $OUTPUT
	samtools sort $file > $OUTPUT
done

	

