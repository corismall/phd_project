#!/bin/bash

### run Gblocks for trimming your Mafft alignment, change parameters to relaxed selection for shorter alignment sequences
FASTA="/home/corinn/Documents/sequences/ITS/pops/fasta/full_renamed_minus_aw_d_og_renamedmafft.fasta-gb"
OUT="/home/corinn/Documents/sequences/ITS/pops/fasta/trees_raxml"

cd $FASTA
Gblocks

''' contruct phylogenetic tree using RAxML, GTR + GAMMA substitution models with 1000 tree replicates for bootstrapping
first command checks the small alignment for MSA format errors, use --parse instead of --check for larger alignments, 
--parse will also compress the fasta file to shorten loading time and will estimate memory and # of CPUs/threads requirements '''

raxml-ng --check --msa $FASTA --model GTR+G --prefix $OUT/T1
raxml-ng --parse --msa $FASTA --model GTR+G --prefix $OUT/T2

#construct tree
raxml-ng --msa $FASTA --model GTR+G --prefix $OUT/T3 --threads 2 --seed 2

#perform bootstrapping
raxml-ng --support --tree T3.raxml.bestTree --bs-trees allbootstraps --prefix T13 --threads 2


### can run previous 2 commands in one

raxml-ng --all --msa $FASTA --model GTR+G --prefix $OUT/T15 --seed 2 --threads 2 --bs-metric fbp,tbe
