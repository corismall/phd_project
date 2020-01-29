library(plyr)
library(ggplot2)
library(tidyr)
library(dplyr)


species <- "S. chilense"
sites <- as.data.frame(read.csv("/home/corinn/Documents/Sampling_trip/isolate_list_peru2019_total.csv", sep = ",", header = T))
blast <- as.data.frame(read.csv("/home/corinn/Documents/sequences/ITS/southern_pops/blast_results/S_chilense/blastresults_chil.csv", sep = ",", header = T))
 
csites <- sites[which(sites$Source=="S_chilense"),]
csites <- csites[order(csites$Isolate),]
id <- subset.data.frame(blast, select = c(ID, Organism))
id <- id[order(id$ID),]
#need to sort each by isolate number to then combine!!




plant <- sites$Plant
sites$Site_plant <- paste(site, "_", plant)
sites<-as.data.frame(sites)
sites <- subset.data.frame(sites, select = c(Isolate, Site_plant, Source))
sitesT <- table(sites$Isolate, sites$Site_plant)
sT2 <- prop.table(sitesT, 2)
sT2 <- as.data.frame(sT2)
sT2 <- as.data.frame(sT2)
sT2 <- na.omit(sT2)

csites <- as.data.frame(filter(sites, sites$Source == "S_chilense"))
View(sites)
View(sitesT)
View(sT2)

#psites <- setNames(data.frame(matrix(ncol = 9, nrow = 18)), c("Site", "Total isolates", "pAa", "pAs", 
                                                                 "pAs?", "pAx", "pUx", "p?", "pB"))
#psites$Site <- sites[which(!duplicated(sites$Site)), "Site"]

myT <- table(csites$Species, csites$Site)
myT2 <- prop.table(myT, 2)
myT2 <- as.data.frame(myT2)
myT2 <- na.omit(myT2)
View(myT2)
colnames(myT2) <- c("Species","Site","Frequency")

title <- "Isolate Count by site"
title <- paste(title, species)
title <- gsub("_", ".", title)

ggplot(data=myT2) + aes(x = myT2$Site, y = myT2$Frequency, fill = myT2$Species) + 
  geom_bar(stat = "identity") +
  ggtitle(title) + xlab("Site") +
  ylab("Species frequency") + theme(axis.text.x= element_text(angle = 90)) + scale_fill_discrete(name = "Species")


ggplot(csites) + aes(x = csites$Site, fill = csites$Species) + 
  geom_bar(position = position_dodge()) + scale_y_continuous(breaks = c(0, 2, 4, 6, 8, 10, 12, 14, 16, 18)) +
  ggtitle(title) + xlab("Site") + 
  ylab("Species count") + theme(axis.text.x= element_text(angle = 45)) + scale_fill_discrete(name = "Species")


ggplot(data=sites) + aes(x = sites$Site_plant, fill = sites$Source) + 
  geom_bar() +
  ggtitle(title) + xlab("Site") +
  ylab("Isolate count") + theme(axis.text.x= element_text(angle = 45)) + scale_fill_discrete(name = "Host")


ggplot(sites, aes(sites$Isolate~sites$Site_plant, fill= sites$Source)) + geom_bar(stat = "identity")


