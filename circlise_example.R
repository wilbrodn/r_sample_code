#Create data
name=c(3,10,10,3,6,7,8,3,6,1,2,2,6,10,2,3,3,10,4,5,9,10)
feature=paste("feature ", c(1,1,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5) , sep="")
dat <- data.frame(name,feature)
dat <- with(dat, table(name, feature))

# Charge the circlize library
install.packages("circlize")
library(circlize)

# Make the circular plot
chordDiagram(as.data.frame(dat), transparency = 0.5)

View(dat)
str(dat)

getwd()
setwd("C:/Users/gertruden/Documents/MyR1")
mapping<-read.csv("./data/map.csv", header = T, stringsAsFactors = F)
str(mapping)
mapp <- data.frame(mapping)
map <- with(mapp, table(map1, datasource))


# Make the circular plot
chordDiagram(as.data.frame(map), transparency = 0.5)
