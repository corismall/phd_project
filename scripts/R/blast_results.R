library(tidyr)
library(dplyr)

blast_res <- as.data.frame(read.csv("/home/corinn/Documents/sequences/ITS/pops/blast_results/S_chilense/blastresults.csv",  sep = ",", header = T))
isolate_numv <- blast_res$Query_ID
top_hit_genus<- blast_res$TopHit_genus
top_hit_species <- blast_res$TopHit_species
pid <- blast_res$Hit_pid


