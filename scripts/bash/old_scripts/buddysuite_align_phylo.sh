#!/bin/bash

HOME=/home/corinn/Documents/sequences/ITS/set1_26_7_19/generated_seqs
SEQS=$HOME/all_isos.fasta

alignbuddy SEQS -ga "mafft" -p "--auto --thread 8"
