#plot rxml tree and tree subsets by species

library(dplyr)
library(tidyr)
library(ape)
library(ggtree)
library(treeio)

#read in tree
t = read.tree("/home/corinn/Documents/sequences/ITS/pops/fasta/trees_raxml/T13.raxml.rooted.support")

#how to subset tree
t_o <- tree_subset(t, "187", levels_back = 1)
plot(t_o)

#read in isolate information
iso_list <- as.data.frame(read.csv("/home/corinn/Documents/Sampling_trip/isolate_list_peru2019_total - TOTAL(1).csv", sep = ",", header = T))
blast_res <- as.data.frame(read.csv("/home/corinn/Documents/sequences/ITS/pops/blast_results/all/all_blastresults.csv", sep = ",", header = T, colClasses = c("factor", "character","character", "numeric")))

#create full species name, rearrange dataset
blast_res$fullname <- paste(blast_res$TopHit_genus,blast_res$TopHit_species, sep = " ")
blast_res <- data.frame(tip.label = blast_res$fullname,label = blast_res$Query_ID,pid = blast_res$Hit_pid)
  
#create plotable object
blast_res2 <- subset.data.frame(blast_res[blast_res$label %in% c("116", "187"),])
colnames(blast_res2) = c("hit","Newick_label","pid")

#rearrange dataframe
blast_res2 <- blast_res2[,c(2,1,3)]

#plot tree
p <- ggtree(t_o) %<+% blast_res2
p2 <- p + geom_tiplab() 
p3 <- p2 + geom_tippoint(aes(shape = hit, color = hit, size = pid))
p3


