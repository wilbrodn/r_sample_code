##Data Analysis Case Study: ##
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##Changes in Fine Particle Air Pollution in the U.S.#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Loading and Processing the Raw Data

#Reading in the 1999 data
pm0 <- read.csv("MyR/annual_all_1999.csv", comment.char = "#", header = T, sep = ",", na.strings = "")
dim(pm0)
head(pm0[,1:13])

#Column names
cnames <- readLines("MyR/annual_all_1999.csv", 1)
cnames <- strsplit(cnames, ",", fixed = TRUE)
## Ensure names are properly formatted
names(pm0) <- make.names(cnames[[1]])
head(pm0[, 1:13])


x0<-pm0$X.Arithmetic.Mean.
summary(x0)
mean (is.na(x0))


pm1 <- read.csv("MyR/annual_all_2016.csv", comment.char = "#", header = T, sep = ",", na.strings = "")
dim(pm1)
head(pm1[,1:13])

x1<-pm1$Arithmetic.Mean
summary(x1)
mean (is.na(x1))

boxplot(log(x0), log(x1))

summary(x0)
summary(x1)
neg0<-x0<0
summary(neg0)
mean(neg0, na.rm=T)


site0 <- unique(subset(pm0, X.State.Code. == 36, c(X.County.Code., X.Site.Num.)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.Num)))
#Then we create a new variable that combines the county code and the site ID into a single string.
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")
str(site0)
str(site1)


both <- intersect(site0, site1)
print(both)


## Find how many observations available at each monitor
pm0$county.site <- with(pm0, paste(X.County.Code., X.Site.Num., sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.Num, sep = "."))
cnt0 <- subset(pm0, X.State.Code. == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)

## 1999
sapply(split(cnt0, cnt0$county.site), nrow)
## 2012
sapply(split(cnt1, cnt1$county.site), nrow)

both.country<-5
both.id<-110

## Choose county 63 and side ID 2008
pm0sub <- subset(pm0, X.State.Code.== 36 & X.County.Code. == both.country & X.Site.Num. == both.id)
pm1sub <- subset(pm1, State.Code == 36 & County.Code == both.country & Site.Num == both.id)

dates1 <- as.Date(as.character(pm1sub$Date.of.Last.Change), "%Y%m%d")
x1sub <- pm1sub$Arithmetic.Mean
dates0 <- as.Date(as.character(pm0sub$X.Date.of.Last.Change.), "%Y%m%d")
x0sub <- pm0sub$X.Arithmetic.Mean.
## Find global range
rng <- range(x0sub, x1sub, na.rm = T)
par(mfrow = c(1, 2), mar = c(4, 5, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng, xlim = c(1, 12), xlab = "", ylab = expression(PM[2.5]* " (" * mu * g/m^3 * ")"))
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng, xlab = "", ylab = expression(PM[2.5]* " (" * mu * g/m^3 * ")"))
abline(h = median(x1sub, na.rm = T))







