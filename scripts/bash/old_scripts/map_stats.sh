#!/bin/bash

HOME=/mnt
REF=$HOME/AlternariaReference/NL03003.fasta
MAP_F=$HOME/AlternariaMapped/*.sam
OUT_F=$HOME/AlternariaMapped/mapstats/
OUT_Q=$HOME/AlternariaMapped/mapq/

#mean read depth; breadth of coverage;proportion of reads that map to the reference

for file in $MAP_F; do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.sorted.bam}
	echo $OUTPUT
	#samtools depth -a $file | awk '{c++;s+=$3}END{print s/c}' > $OUT_F/"$OUTPUT.mrd.txt"
	#samtools depth -a $file | awk '{c++; if($3>0) total+=1}END{print (total/c)*100}'> $OUT_F/"$OUTPUT.bc.txt" 
	samtools flagstat $file > $OUT_F/"$OUTPUT.rm.txt"
done

#extract MAPQ scores from sam files

for file in $MAP_F; do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.sam}
	echo $OUTPUT
	samtools view $file | awk -F "\t" '{print $5}' > $OUT_Q/"$OUTPUT.mapq.txt"
done

HOME=/mnt
MAP_F=$HOME/AlternariaMapped/*.bam
OUT_F=$HOME/AlternariaMapped/mapstats/
OUT_Q=$HOME/AlternariaMapped/mapq/

for file in $MAP_F; do
	NAME=$(basename "$file")
	echo $NAME
	OUTPUT=${NAME%.bam}
	echo $OUTPUT
	samtools stats $file > $OUTPUT.bam.stats
	mv $OUTPUT.bam.stats $OUT_F
done





