#Knowledge based, Collaborative, Content Based
#Content based - easiest to create , makes similarity matrices.
#KBRS/ Apriori Algorithm/ Market basket Analysis - Is done on transactions
library(arules)
library(arulesViz)
library(dplyr)
setwd("~/Desktop/MLWBA")
#### Import the data ####
pos = read.csv("POS DATA.csv")
View(pos)

data = pos %>% group_by(Order) %>%
  summarise(Description=paste(Description,collapse = ","))
View(data)

write.csv(data$Description, "big123.csv", quote=FALSE, row.names = FALSE)

#Import file using Apriori algorithm#
big = read.transactions("big123.csv",sep=",")
summary(big)

itemFrequencyPlot(big, topN=100)

rules = apriori(big, parameter = list(supp=0.005,conf=0.0))
write(rules,file="bigrules.csv",sep=",", row.names=FALSE)

plot(rules,method = "graph", control = list(type="item"),interactive = T)

