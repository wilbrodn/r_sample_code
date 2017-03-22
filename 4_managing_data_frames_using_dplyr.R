##dplyr Grammar
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#select: return a subset of the columns of a data frame, using a flexible notation
#filter: extract a subset of rows from a data frame based on logical conditions
#arrange: reorder rows of a data frame
#rename: rename variables in a data frame
#mutate: add new variables/columns or transform existing variables
#summarise / summarize: generate summary statistics of different variables in the data frame, possibly within strata
#%>%: the “pipe” operator is used to connect multiple verb actions together into a pipeline

#Common dplyr Function Properties
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#1. The first argument is a data frame.
#2. The subsequent arguments describe what to do with the data frame specified in the first
#argument, and you can refer to columns in the data frame directly without using the $ operator
#(just use the column names).
#3. The return result of a function is a new data frame
#4. Data frames must be properly formatted and annotated for this to all be useful. In particular,
#the data must be tidy⁵². In short, there should be one observation per row, and each column
#should represent a feature or characteristic of that observation.


##Installing the dplyr package
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
install.packages("dplyr") #installing from CRAN
#To install from GitHub you can run
install_github("hadley/dplyr")
#load it into your R session with the library() function.
library(dplyr)

##select()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Data link: http://www.biostat.jhsph.edu/~rpeng/leanpub/rprog/chicago_data.zip
chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)
head(chicago)

names(chicago)[1:5]
subset <- select(chicago, city:date)
head(subset)
head(select(chicago, -(city:dptp)))

#same as below
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])
head(chicago[, -(1:3)])

subset <- select(chicago, ends_with("2"))
str(subset)

subset <- select(chicago, starts_with("d"))
str(subset)


##filter()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
chic.f<-filter(chicago, pm25tmean2 > 30)
str(chic.f)

summary(chic.f$pm25tmean2)

chic.f<-filter(chicago, pm25tmean2>30 & tmpd>80)
select(chic.f, date,tmpd, pm25tmean2)

##arrange()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
chicago<-arrange(chicago, date)  #arrange by date ascending
head(select(chicago, date, pm25tmean2),5) #see first 5 observations
tail(select(chicago, date, pm25tmean2),5) #see the last 5 observations

chicago<-arrange(chicago, desc(date)) #arrange b data descending
head(select(chicago, date, pm25tmean2),5) #see first 5 observations
tail(select(chicago, date, pm25tmean2),5) #see the last 5 observations

chicago<-arrange(chicago, date, pm25tmean2) #for many levels
head(chicago)

##rename()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
head(chicago[, 1:5], 3)
chicago<-rename(chicago, dewpoint=dptp, pm25=pm25tmean2)
head(chicago[, 1:5], 3)


##mutate() helps to create variables from other variables e.g smoothing etc
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
chicago<-mutate(chicago, pm25detrend=pm25-mean(pm25, na.rm = T))
tail(chicago)
#transmute() does like mutate() but drops all the old variables
head(transmute(chicago, pm10detrend=pm10tmean2-mean(pm10tmean2, na.rm=T), o3detred=o3tmean2-mean(o3tmean2, na.rm=T)),50)


##group_by()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#used to generate summary stats for strata 
chicago<-mutate(chicago,year=as.POSIXlt(date)$year+1900)
years<-group_by(chicago, year)
summarise(years, pm25=mean(pm25, na.rm=T), o3= max(o3tmean2, na.rm=T), no2=median(no2tmean2, na.rm = T))

qq<-quantile(chicago$pm25,seq(0,1,0.2), na.rm=T)
chicago<-mutate(chicago, pm25.quint=cut(pm25, qq))
quint<-group_by(chicago, pm25.quint)
summarise(quint, o3=mean(o3tmean2, na.rm = T), no2=mean(no2tmean2, na.rm = T))

## %>%
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#The pipeline operater %>% is very handy for stringing together multiple dplyr functions in a sequence
#of operations. Notice above that every time we wanted to apply more than one function, the sequence
#gets buried in a sequence of nested function calls that is difficult to read, i.e.
#####> third(second(first(x)))
#This nesting is not a natural way to think about a sequence of operations. The %>% operator allows
#you to string operations in a left-to-right fashion, i.e.
#####> first(x) %>% second %>% third
##Take the example that we just did in the last section

chicago.sum<-mutate(chicago, pm25.quint=cut(pm25, qq))%>% group_by(pm25.quint)%>%summarise(o3=median(o3tmean2, na.rm = T), no2=mean(no2tmean2, na.rm = T))
chicago.sum

#Another example might be computing the average pollutant level by month
chicago.by.month<-mutate(chicago, month=as.POSIXlt(date)$mon+1)%>%
  group_by(month)%>%
  summarise(pm25=mean(pm25, na.rm=T),
            o3=max(o3tmean2, na.rm=TRUE),
            no2=median(no2tmean2, na.rm=T))


##Summary
#-----------------------------#
#The dplyr package provides a concise set of operations for managing data frames. With these
#functions we can do a number of complex operations in just a few lines of code. In particular,
#we can often conduct the beginnings of an exploratory analysis with the powerful combination of
#group_by() and summarize().
#Once you learn the dplyr grammar there are a few additional benefits
#####• dplyr can work with other data frame “backends” such as SQL databases. There is an SQL
#####interface for relational databases via the DBI package
#####• dplyr can be integrated with the data.table package for large fast tables
#The dplyr package is handy way to both simplify and speed up your data frame management code.
#It’s rare that you get such a combination at the same time!


