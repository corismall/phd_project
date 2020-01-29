library(ggplot2)
library(ggthemes)
library(extrafont)
library(dplyr)
library(scales)
library(extdplyr)

sites <- as.data.frame(read.csv("/home/corinn/Documents/Sampling_trip/isolate_list_peru2019.csv", sep = ",", header = T))

s18 <- as.data.frame(subset(sites, sites$Site == 'S18'))
rownames(s18) <- 1:nrow(s18)
Paa <- ((nrow(s18[s18$Species == "A. alternata",])) / nrow(s18)) *100
Phm <- ((nrow(s18[s18$Species == "?",])) / nrow(s18)) *100
Pas <- ((nrow(s18[s18$Species == "A. solani",])) / nrow(s18)) *100
Pb <- ((nrow(s18[s18$Species == "Botrytis?",])) / nrow(s18)) *100
Pashm <- ((nrow(s18[s18$Species == "A. solani?",])) / nrow(s18)) *100
Pax <- ((nrow(s18[s18$Species == "A. x",])) / nrow(s18)) *100
Pux <- ((nrow(s18[s18$Species == "U. x",])) / nrow(s18)) *100

psites <- setNames(data.frame(matrix(ncol = 9, nrow = 16)), c("Site", "Total isolates", "% Aa", "% As", 
                                                                 "% As?", "% Ax", "% Ux", "% ?", "% B"))
psites$Site <- sites[which(!duplicated(sites$Site)), "Site"]

#now i want to create a list for the isolate totals per site/ fill in the rest of the dataframe for each site

View(psites)

#DO the same for all like 18
s18 <- as.data.frame(subset(sites, sites$Site == 'S18'))
rownames(s18) <- 1:nrow(s18)
Paa <- ((nrow(s18[s18$Species == "A. alternata",])) / nrow(s18)) *100
Phm <- ((nrow(s18[s18$Species == "?",])) / nrow(s18)) *100
Pas <- ((nrow(s18[s18$Species == "A. solani",])) / nrow(s18)) *100
Pb <- ((nrow(s18[s18$Species == "Botrytis?",])) / nrow(s18)) *100
Pashm <- ((nrow(s18[s18$Species == "A. solani?",])) / nrow(s18)) *100
Pax <- ((nrow(s18[s18$Species == "A. x",])) / nrow(s18)) *100
Pux <- ((nrow(s18[s18$Species == "U. x",])) / nrow(s18)) *100

s21 <- subset(sites, sites$Site == 'S21')
s29 <- subset(sites, sites$Site == 'S29')
s31 <- subset(sites, sites$Site == 'S31')
s32 <- subset(sites, sites$Site == 'S32')
s33 <- subset(sites, sites$Site == 'S33')
s39 <- subset(sites, sites$Site == 'S39')
s43 <- subset(sites, sites$Site == 'S43')
s47 <- subset(sites, sites$Site == 'S47')
s48 <- subset(sites, sites$Site == 'S48')
s51 <- subset(sites, sites$Site == 'S51')
s53 <- subset(sites, sites$Site == 'S53')
s72 <- subset(sites, sites$Site == 'S72')
s74 <- subset(sites, sites$Site == 'S74')
s76 <- subset(sites, sites$Site == 'S76')
s78 <- subset(sites, sites$Site == 'S78')



#stack barplot of percentages of each species by site




ggsites <- ggplot() + geom_bar(aes(y = Species, x = Site, fill = Species), data = sites, stat = "identity")
ggsites



View(sites)

ggplot(data=sites, aes(x = sites$Site, y = sites$Species, fill = sites$Species)) + 
  geom_bar() +
  ggtitle(expression('Species by site')) + xlab("Site") + 
  ylab("Species count") + theme(axis.text.x= element_text(angle = 45))



