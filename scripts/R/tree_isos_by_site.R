library(dplyr)
library(ggplot2)
library(tidyr)
library(ape)
library(phytools)
library(mapdata)
library(viridis)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("treeio")
library(treeio)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree")
library(ggtree)
library(stringr)
library(tidytree)
library(data.table)
library(phylogram)
library(plotrix)
library(RColorBrewer)

#read in various files
iso_list <- as.data.frame(read.csv("/home/corinn/Documents/Sampling_trip/isolate_list_peru2019_total - TOTAL(1).csv", sep = ",", header = T))
blast_res <- as.data.frame(read.csv("/home/corinn/Documents/sequences/ITS/pops/blast_results/all/all_blastresults.csv", sep = ",", header = T))
species = unique(blast_res[,c(2,3)])
coordinates <- as.data.frame(read.csv("/home/corinn/Documents/Sampling_trip/phd_project_isolations.xlsx - Sites.csv", sep = ",", header = T))

#subset isolate #s and corresponding sites
isosites <- subset(iso_list, select = c(Isolate,Site))
isosites$Isolate <- as.list(isosites$Isolate)

#subset site coordinates
site_coords <- subset(coordinates, select = c(Site,Longitude,Latitude))
mergeddfs <- merge(isosites,site_coords, by = "Site") 
cc <- tibble(Latitude = mergeddfs$Latitude, Longitude = mergeddfs$Longitude, label = mergeddfs$Isolate)

#subset site coordinates for only isolates in tree
cc_sub <- as.data.frame(read.csv("/home/corinn/Documents/sequences/ITS/pops/fasta/trees_raxml/iso_cc.csv", sep = ",", header =T))
#cc_sub <- subset(cc, label %in% t$tip.label)
#add controls (without coordinates = na)
fix(cc_sub)

#read in tree, drop duplicates (not controls), fix labels, subset cc, make sure t_df is converted to a phylo object
t = read.tree("/home/corinn/Documents/sequences/ITS/pops/fasta/trees_raxml/T13.raxml.rooted.support")
t_as <- tree_subset(t,"51", levels_back = 8)
t_aa <- tree_subset(t,"358", levels_back = 17)
t_aab <- tree_subset(t, "26", levels_back = 2)
t_u <- tree_subset(t, "59", levels_back = 2)
t_o <- tree_subset(t, "93", levels_back = 2)

#if blast id > 90 then keep as true species
accepted_blasts <- subset.data.frame(blast_res,blast_res$Hit_pid>90,select = c("Query_ID","TopHit_genus","TopHit_species","Hit_pid"))

#plot tree
plot.phylo(t_o, show.node.label = T, edge.color = c(accepted_blasts$TopHit_genus,accepted_blasts$TopHit_species))

#color branches based on species (HitpID)
ggtree(t_aa, aes(color=species))
plot(t_o)


#write.csv(cc_sub, file ="/home/corinn/Documents/sequences/ITS/pops/fasta/trees_raxml/iso_cc.csv", sep = ",")
#map tree to 
t <- as.phylo(t)
t_map <- phylo.to.map(t,cc_sub,type=c("phylogram","direct"), rotate=FALSE, database ="worldHires", regions=c("Chile", "Peru"),
                      plot = FALSE,map("worldHires", xlim=c(-76, -65), ylim=c(-26, -14), col="gray95",fill=TRUE),
                      map("worldHires",add=TRUE,"Chile", xlim=c(-76, -65), ylim=c(-26, -14),col="gray92", fill=TRUE),
                      map("worldHires",add=TRUE,"Peru", xlim=c(-76, -65), ylim=c(-26, -14),col="gray92", fill=TRUE))

cols <- setNames(sample(viridis(n=Ntip(t))), t$tip.label)

plot(t_map, direction="rightwards",colors=cols)



#######################

ggtree(tree_table) + geom_tippoint(mergeddfs$Site)
phylo.to.map(tree_table)
