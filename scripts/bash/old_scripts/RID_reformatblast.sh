#!/bin/bash

HOME=/home/corinn/Documents/sequences/ITS/set1_26_7_19/generated_seqs/blast_results
BLASTS=$HOME/*.tab

for file in $BLASTS; do
	echo "$file"
	NAME=$(basename "$file" .tab)
	echo "$NAME"
	RIDF=$(grep 'RID:' $file)
	RID=$(echo "$RIDF" | cut -d' ' -f3)
	echo "$RID"
	OUT=species_id_blastres_$NAME.out
	blast_formatter -rid $RID -outfmt '7 qseqid sseqid pident evalue staxids sscinames scomnames sskingdoms stitle' > $OUT
	mv $OUT $HOME
done
