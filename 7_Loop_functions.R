#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Hint!
## remove (almost) everything in the working environment.
## You will get no warning, so don't do this unless you are really sure.
rm(list=ls())
#''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

####LOOP functions
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬`

#• lapply(): Loop over a list and evaluate a function on each element
#• sapply(): Same as lapply but try to simplify the result
#• apply(): Apply a function over the margins of an array
#• tapply(): Apply a function over subsets of a vector
#• mapply(): Multivariate version of lapply

###lapply()
#````````````````````````````````````````````````````````````````````````````````#
#1. it loops over a list, iterating over each element in that list
#2. it applies a function to each element of the list (a function that you specify)
#3. and returns a list (the l is for “list”).

#Body below
lapply
x<-list(a=1:5, b=rnorm(10))
lapply(x,mean)
y<-lapply(x,sd)
y
str(y)

#can be used to evaluate a function multiple times each with a diffrerent e.g. here with runif
x<-1:4
lapply(x,runif)

#any arguments will be passed to the function bwing called. instead of default (0,1), we can set random nos from runif to (1, 10)
x<-1:4
lapply(x, runif, min=0, max=10)

#loop functions use anonymous functions
x<-list(a=matrix(1:4, 2,2), b=matrix(1:6, 3,2))
x
#we can extract the first column in each using anonymous functiosn in lapply
lapply(x, function(elt){elt[,1]})

###sapply()
#````````````````````````````````````````````````````````````````````````````````#
#like lapply. Calls lapply and simplifies the output. see its arigorithm
##• If the result is a list where every element is length 1, then a vector is returned
##• If the result is a list where every element is a vector of the same length (> 1), a matrix is returned.
##• If it can’t figure things out, a list is returned

x<-list(a=1:5, b=rnorm(10), c=rnorm(21,2,3), d=runif(20,1,10))
lapply(x,mean) #returns a vector
sapply(x,mean) #returns a list

###split()
#````````````````````````````````````````````````````````````````````````````````````````#
#sometimes referred toas map-reduce
split
x<-c(rnorm(20), runif(20), rnorm(20,1))
f<-gl(3,20)
f
split(x,f)

#split followed by lapply
lapply(split(x,f), mean)

###splitting a data frame()
#````````````````````````````````````````````````````````````````````````````````````````#
library(datasets)
head(airquality)
#we can split data frame by month so we have separate datasets fro each month
s<-split(airquality, airquality$Month)
str(s)

#calculae column means
lapply(s, function(x){colMeans(x[, c("Ozone", "Solar.R", "Wind")])})
#sapply provides a better readable output
sapply(s, function(x){colMeans(x[, c("Ozone", "Solar.R", "Wind")])})
#there are nas so first remove them
sapply(s, function(x){
  colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = T)
})

#interaction
x<-rnorm(10)
f1<-gl(2,5)
f2<-gl(5,2)
interaction(f1,f2)
str(split(x, list(f1,f2)))

#there are some empty levels that can be removed
str(split(x, list(f1,f2), drop=T))


###tapply()
#````````````````````````````````````````````````````````````````````````````````````````#

#more like a combination of split() and lapply() 

## Simulate some data
x <- c(rnorm(10), runif(10), rnorm(10, 1))
## Define some groups with a factor variable
f <- gl(3, 10)
f
tapply(x, f, mean)

tapply(x, f, mean, simplify = F)
tapply(x, f, range)

###apply()
#````````````````````````````````````````````````````````````````````````````````````````#

#
str(apply)
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) ## Take the mean of each column
apply(x, 1, sum) ## Take the sum of each row

###Col/Row Sums and Means
#````````````````````````````````````````````````````````````````````````````````````````````#
#• rowSums = apply(x, 1, sum)
#• rowMeans = apply(x, 1, mean)
#• colSums = apply(x, 2, sum)
#• colMeans = apply(x, 2, mean)
###The shortcut functions are heavily optimized and hence are much faster
###It’s arguably more clear to write colMeans(x) in your code than apply(x, 2, mean).

###Other Ways to Apply()
#``````````````````````````````````````````````````````````````````````````````````````````#
#For example, you can compute quantiles of the rows of a matrix using the quantile() function.
x <- matrix(rnorm(200), 20, 10)
## Get row quantiles
apply(x, 1, quantile, probs = c(0.25, 0.75))


a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
a
apply(a, c(1, 2), mean)

rowMeans(a, dims = 2) ## Faster


###mapply()
#``````````````````````````````````````````````````````````````````````````````````````````````#

#The mapply() function is a multivariate apply of sorts which applies a function in parallel over a set of arguments. 
str(mapply) #slightly different structure

list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1)) #tedious to type
mapply(rep, 1:4, 4:1)


#Another example
noise <- function(n, mean, sd) {
  rnorm(n, mean, sd)
  }
## Simulate 5 randon numbers
noise(5, 1, 2)
## This only simulates 1 set of numbers, not 5
noise(1:5, 1:5, 2)

#Here we can use mapply() to pass the sequence 1:5 separately to the noise() function so that we
#can get 5 sets of random numbers, each with a different length and mean.
mapply(noise, 1:5, 1:5, 2)

#The above call to mapply() is the same as
list(noise(1, 1, 2), noise(2, 2, 2), noise(3, 3, 2), noise(4, 4, 2), noise(5, 5, 2))


###Vectorizing a Function
#``````````````````````````````````````````````````````````````````````````````````#

#The mapply() function can be use to automatically “vectorize” a function. 
#It can be used to take a function that typically only takes single arguments and create a new function that can take vector arguments.
#here’s an example of a function that computes the sum of squares given some data, a mean parameter and a standard deviation.

sumsq <- function(mu, sigma, x) {
  sum(((x - mu) / sigma)^2)
  }

x <- rnorm(100) ## Generate some data
sumsq(1:10, 1:10, x) ## This is not what we want

mapply(sumsq, 1:10, 1:10, MoreArgs = list(x = x))
#alternatively use vectorise()
vsumsq <- Vectorize(sumsq, c("mu", "sigma"))
vsumsq(1:10, 1:10, x)


###Summary
#```````````````````````````````````````````````````````````````#
#• The loop functions in R are very powerful
#• The operation of a loop function involves iterating over an R object (e.g. a list or vector or
####matrix), applying a function to each element of the object, and the collating the results and
####returning the collated results.
#• Loop functions make heavy use of anonymous functions, which exist for the life of the loop
####function but are not stored anywhere
#• The split() function can be used to divide an R object in to subsets determined by another
####variable which can subsequently be looped over using loop functions.










