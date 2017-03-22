###CRAN one doesn't work
install.packages("gtrendsR")
library(gtrendsR)
###Exmple
library(gtrendsR)
usr <- "ntawihawilbrod@gmail.com"
psw <- "bigthoughtsbigresults"
session<-gconnect(usr, psw) 
lang_trend <- gtrends(query = iconv("data", to = "UTF-8"), res="7d")
plot(lang_trend)

res <- gtrends("nhl", geo = c("CA", "US"))
plot(res)

###Install using github. this will work



install.packages("devtools")
library(devtools)
if (!require("devtools")) install.packages("devtools")
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
res <- gtrends("nhl", geo = c("CA", "US"))
plot(res)
head(res)
str(res)

m7<-gtrends(c("Museveni", "Besigye"))
plot(m7)
