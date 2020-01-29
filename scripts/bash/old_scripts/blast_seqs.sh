#!/bin/bash

HOME=/home/corinn/Documents/sequences/ITS/set1_26_7_19/generated_seqs
SEQS=$HOME/*.fasta
BLAST_RES=$HOME/blast_results/

for file in $SEQS;do
	echo $file
	NAME=$(basename "$file" .fasta)
	echo "$NAME"
	OUTPUT=blast_result_rid$NAME.tab
	echo $OUTPUT
	blastn -db nt -query $file -out $OUTPUT -remote 
	mv $OUTPUT $BLAST_RES
done
