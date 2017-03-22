#GETTING DATA IN AND OUT OF R

#Reading data
#read.csv, read.table to read tabular data
#readLines, for reading lines of a text file
#source, for reading in R code files (inverse of dump)
#dget, for reading in R code files (inverse of dput)
#load, for reading in saved workspaces
#unserialize, for reading single R objects in binary form

#writing data
#write.table, for writing tabular data to text files (i.e. CSV) or connections
#writeLines, for writing character data line-by-line to a file or connection
#dump, for dumping a textual representation of multiple R objects
#dput, for outputting a textual representation of an R object
#save, for saving an arbitrary number of R objects in binary format (possibly compressed) to a file.
#serialize, for converting an R object into a binary format for outputting to a connection (or file).

#help example
## using count.fields to handle unknown maximum number of fields
## when fill = TRUE

test1 <- c(1:5, "6,7", "8,9,10")
tf <- tempfile()
writeLines(test1, tf)

read.csv(tf, fill = TRUE) # 1 column
ncol <- max(count.fields(tf, sep = ","))
read.csv(tf, fill = TRUE, header = FALSE,
         col.names = paste0("V", seq_len(ncol)))
unlink(tf)

## "Inline" data set, using text=
## Notice that leading and trailing empty lines are auto-trimmed

read.table(header = TRUE, text = "
           a b
           1 2
           3 4
           ")

#files
setwd("~/MyR") #working directory to MyR
data<-read.table("~/MyR/data.txt", header = T, nrows = 42) #NB: this line can't read everything due to missing values
data1<-read.csv("~/MyR/data.csv", header = T)
class(data1)
attributes(data1)
data<-data1

#calculating memory
mem<-8*1000000000 #bytes
mem<-8*nrow(data1)*ncol(data1) #bytes
x<-2^20
memmb=mem/x
memgb=memmb/1000
mem
memmb
memgb



#USING readr PACKAGE
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
install.packages("readr") #Installing readr package
mydata<-read_csv("~/MyR/data.csv")



#USING TEXTUAL AND BINARY FORMATS FOR STORING DATA
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Parsing r object using dput() and gettign it using dget()

#get a data frame and print dput outcome to console
mydata=read.csv("~/MyR/data.csv", header=T)
dput(mydata)
#Send dput output to a file
dput(mydata, file="mydata.R")
#read dput output from a file
new.mydata<-dget("mydata.R")
new.mydata

#multiple objects can be parsed using dump() and obtained using source()
x<-"hello"
y<-c(1:10)
dump(c("x","y"), file ="data.R")
rm("x","y")  #removes the values from working area
source("data.R")
str(y)  #prints teh structure of an object

#Binary formats
a <- data.frame(x = rnorm(100), y = runif(100))
b <- c(3, 4.4, 1 / 3)
a
b
## Save 'a' and 'b' to a file
save(a, b, file = "mydata.rda")
## Load 'a' and 'b' into your workspace
load("mydata.rda")
#If you have a lot of objects that you want to save to a file, you can save all objects in your workspace using the save.image() function.
## Save everything to a file
save.image(file = "mydata.RData")
## load all objects in this file
load("mydata.RData")
#extensions are not fixed, but these are preffered

#The serialize() function is used to convert individual R objects into a binary format that can be
#communicated across an arbitrary connection. This may get sent to a file, but it could get sent over
#a network or other connection.

x <- list(1, 2, 3)
serialize(x, NULL)

x <- serialize(list(1,2,3), NULL)
x
unserialize(x)

## see also the examples for saveRDS

#INTERFACES TO THE OUTSIDE WORLD
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#file, opens a connection to a file
#gzfile, opens a connection to a file compressed with gzip
#bzfile, opens a connection to a file compressed with bzip2
#url, opens a connection to a webpage

#File connections
####################
str(file)

#"r" open file in read only mode
#"w" open a file for writing (and initializing a new file)
#"a" open a file for appending
#"rb", "wb", "ab" reading, writing, or appending in binary mode (Windows)

## Create a connection to 'example.txt'
con <- file("example.txt")
## Open connection to 'example.txt' in read-only mode
open(con, "r")
con
## Read from the connection
data <- read.csv(con, header=F)
## Close the connection
close(con)

###which is the same as
data <- read.csv("example.txt", header=F)

#Reading lines of a text
## Open connection to gz-compressed text file
con <- gzfile("ex.gz")
x <- readLines(con, 10)
x

#Reading From a URL Connection
#The readLines() function can be useful for reading in lines of webpages.
## Open a URL connection for reading
con <- url("http://www.mak.ac.ug", "r")
## Read the web page
x <- readLines(con)
## Print out the first few lines
head(x)
x

