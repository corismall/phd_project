#!/bin/bash

HOME=/home/corinn/
REF=$HOME/Documents/A.solani_sequencedata_F19FTSEUHT0141/reference/GCA_002952155.1_ASM295215v1_genomic.fna
STRAIN=$HOME/Documents/A.solani_sequencedata_F19FTSEUHT0141/AlternariaMapped/*.sorted.bam

for FILE in $STRAIN;do
	NAME=$(basename "$FILE")
	NAME=${NAME%.sorted.bam}
	echo $NAME
	java -jar /home/ubuntu/tools/picard/build/libs/picard.jar MarkDuplicates INPUT=$FILE OUTPUT=$NAME.dedup.sorted.bam METRICS_FILE=metrics.txt
	echo $OUTPUT
done

# indexing dedup.sorted.bam files
HOME=/home/corinn/
STRAIN=$HOME/Documents/A.solani_sequencedata_F19FTSEUHT0141/AlternariaMapped/*dedup.sorted.bam

for FILE in $STRAIN;do
	echo $FILE
	java -jar /home/ubuntu/tools/picard/build/libs/picard.jar BuildBamIndex INPUT=$FILE
done

#for counting reads and number of loci covered by one or more reads

for FILE in $STRAIN;do
	NAME=$(basename "$FILE")
	NAME=${NAME%.dedup.sorted.bam}
	echo $NAME
	java -jar <path to GenomeAnalysisTK.jar> -T CountReads -R $REF -I $FILE












