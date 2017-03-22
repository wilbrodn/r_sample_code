#R NUTS AND BOLTS


#ENTERING INPUT/EVALUATION
x<-1 #Assignment
print(x)  #print
x #auto print
msg<-"hello"
print(msg)
x<-c(10, 40)
x

#VECTORS
#creating
x<-c(0.5,2.3,4.5895) #numerical
2*x
x<-c(T,F) #logical, use T and F is only lazy
x
x<-c("a","b","z") #character
x
x<-1:9 #integer
x
x<-vector("numeric",length = 8) #using vector() to initialise vectors
x
#mixing objects
x<-c(1.7,"a") #character
x
x<-c(T,2) #numeric
x
x<-c(T,"a") #character
x
#explicit coercion
x<-c(0:6)
class(x)
x
as.numeric(x)
as.integer(x)
as.logical(x)
as.character(x)

x<-c("a", "b", "c")
class(x)
as.numeric(x)
as.integer(x)
as.logical(x)
as.character(x)


#MATRICES
#########
#have dimension attribute
m<-matrix(nrow=2, ncol = 3) 
dim(m)
attributes(m)
m
#assign a matrix to a row; columns are created first
m<-1:6
m
dim(m)<-c(2,3)
m
#can be created by column binding, cbind() or row binding, rbind()
x<-1:4
y<-11:14
z<-rbind(x,y)
z
w<-cbind(x,y)
w
#Arithmetic with matrices
2*w
w
w*w
a<-matrix(1:8, nrow = 4, ncol=2)
a
w
a*w
#matrix multiplication
z%*%w
a%*%z
attributes(z) #to know the atributes, use names to assign attributes


#LISTS
#Lists (ex of data types) are special type of vector that can contain elements of different classes
x<-list(1, "a", T, 1+4i)
x
x[4]
#creating a list with a vector
x<-vector("list", length = 6)
x
x[2]

x<-list(1:4, "a", c(T,F),c(2+5i,7, 1+4i))
x


#FACTORS
#data types usd to represent categorical data
x<-factor(c("yes", "no", "yes","no","yes","no","yes","yes","no","no","yes"))
x
#computations on factors
table(x)
#representing underlying factors
unclass(x)

#MISSING VALUES
#is.na() is used to test if there are NA in the data, while is.nan() for NAN, NA have classes, NAN are NA but not all NA are NAN
x<-c(2,5,NA,56, NA,3)
#return a logical vector indicating NA and NAS elements
is.na(x)
is.nan(x)
x<-c(2,5,NA,56, NaN,3)
is.na(x)
is.nan(x)

#DATA FRAMES
#To store tabular data in R
#can store metadata, call by row.names() or column.names()
#created by reading in a dataset using read.table() or read.csv()
#can be created by data.frame()
#Convert to a matrix using data.matrix()
x<-data.frame(foo=17:20, bar=c(T,F,T,F))
x
nrow(x)
ncol(x)

#NAMES
#names in vectors
x<-c(43, 56, 64)
names(x)
names(x)<-c("Kampala", "Kisumu", "Nairobi")
names(x)
x
#names in lists
y<-list("distances"=x, "towns"=c("kisoro"=1, "kabale"=2))
y
names(y)
names(y[2])
#names in matrices
x<-matrix(1:4, nrow=2, ncol=2)
dimnames(x)
dimnames(x)<-list(c("a","b"), c("c","d"))
x
colnames(x)<-c("x","y")
rownames(x)<-c("z","w")
x
#names in data frames
#instead of rownames() use row.names() and instead of colnames() use names()
x<-data.frame(foo=17:20, bar=c(T,F,T,F))
y<-x
names(y)<-c("odd","result")
row.names(y)<-c("a","b", "c", "d")
y





