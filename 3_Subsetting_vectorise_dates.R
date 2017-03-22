##Subsetting R Objects
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#1  The [ operator always returns an object of the same class as the original. It can be used to select multiple elements of an object
#2  The [[ operator is used to extract elements of a list or a data frame. It can only be used to extract a single element and the class of the returned object will not necessarily be a list or data frame.
#3  The $ operator is used to extract elements of a list or data frame by literal name. Its semantics are similar to that of [[.

##Subsetting a Vector
#Vectors are basic objects in R and they can be subsetted using the [ operator.

x <- c("a", "b", "c", "c", "d", "a")
x[1] ## Extract the first element
x[2] ## Extract the second element
x[1:4]
x[c(1, 3, 4)]

#logical operations
u <- x > "a"
u
x[u]

#Similar to
x[x > "a"]


##Subsetting a Matrix
x <- matrix(1:6, 2, 3)
x

x[1, 2]
x[2, 1]
x[1, ] ## Extract the first row
x[, 2] ## Extract the second column

##Dropping matrix dimensions
#By default, when a single element of a matrix is retrieved, it is returned as a vector of length 1 rather than a $1\times 1$ matrix. Often, this is exactly what we want, but this behavior can be turned off by setting drop = FALSE.
x <- matrix(1:6, 2, 3)
x[1, 2]
x[1, 2, drop = FALSE]
x[1, ]
x[1, , drop = FALSE]

#Subsetting Lists
x <- list(foo = 1:4, bar = 0.6)
x
x[[1]]
x[["bar"]]
x$bar
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- "foo"
## computed index for "foo"
x[[name]]
## element "name" doesn't exist! (but no error here)
x$name
## element "foo" does exist
x$foo

###Subsetting Nested Elements of a List
#The [[ operator can take an integer sequence if you want to extract a nested element of a list.
x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
## Get the 3rd element of the 1st element
x[[c(1, 3)]]
## Same as above
x[[1]][[3]]
## 1st element of the 2nd element
x[[c(2, 1)]]


##Extracting Multiple Elements of a List
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)]
###****!!!!Note that x[c(1, 3)] is NOT the same as x[[c(1, 3)]]


##Partial Matching
#Partial matching of names is allowed with [[ and $.
x <- list(aardvark = 1:5)
x$a
x[["a"]]
x[["a", exact = FALSE]]


##Removing NA Values
#A common task in data analysis is removing missing values (NAs).
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
print(bad)
x[!bad]

#What if there are multiple R objects 
x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good
x[good]
y[good]

head(airquality)
good <- complete.cases(airquality)
head(airquality[good, ])



##Vectorized Operations
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
x <- 1:4
y <- 6:9
z <- x + y
z

z <- numeric(length(x))
for(i in seq_along(x)) {
  z[i] <- x[i] + y[i]
}
z
x
x>=2
x<3
y==8
x-y
x/y
x+y

##Vectorized Matrix Operations
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
x <- matrix(1:4, 2, 2)
y <- matrix(rep(10, 4), 2, 2)
x*y #element wise
x/y #element wise
x%*%y  #true matrix multiplication


##Dates and Times
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#Dates are represented by the Date class and times are represented by the POSIXct or the POSIXlt class
#Dates are stored internally as the number of days since 1970-01-01 while times are stored internally as the number of seconds since 1970-01-01.

#Dates in R
## Coerce a 'Date' object from character
x <- as.Date("1970-01-01")
x
#You can see the internal representation of a Date object by using the unclass() function.
unclass(x)
unclass(as.Date("1970-01-02"))

#Times in R
#Times are represented by the POSIXct or the POSIXlt class.
#POSIXct is just a very large integer under the hood. 
### weekdays: give the day of the week
### months: give the month name
### quarters: give the quarter number ("Q1", "Q2", "Q3", or "Q4")
#Times can be coerced from a character string using the as.POSIXlt or as.POSIXct function.
x <- Sys.time()
x
class(x) ## 'POSIXct' object
#The POSIXlt object contains some useful metadata.
p <- as.POSIXlt(x)
names(unclass(p))
p$wday ## day of the week

#You can also use the POSIXct format.
x <- Sys.time()
x ## Already in 'POSIXct' format
unclass(x) ## Internal representation
x$sec ## Can't do this with 'POSIXct'!

p <- as.POSIXlt(x)
p$sec ## That's better

# strptime() function in case your dates are written in a different format.
#strptime() takes a character vector that has dates and times and converts them into to a POSIXlt object.
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)



##Operations on Dates and Times
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y
#Warning: Incompatible methods ("-.Date", "-.POSIXt") for "-"

x <- as.POSIXlt(x)
x-y

x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x-y

## My local time zone
x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
y-x


##Summary
#. Dates and times have special classes in R that allow for numerical and statistical calculations
#. Dates use the Date class
#. Times use the POSIXct and POSIXlt class
#. Character strings can be coerced to Date/Time classes using the strptime function or the as.Date, as.POSIXlt, or as.POSIXct

#changing timezones
x<-Sys.time()
x
y<-format(x, tz="GMT")
y

#changing timezones
d <- c("2009-03-07 12:00", "2009-03-08 12:00", "2009-03-28 12:00", "2009-03-29 12:00", "2009-10-24 12:00", "2009-10-25 12:00", "2009-10-31 12:00", "2009-11-01 12:00")
t1 <- as.POSIXct(d,"America/Los_Angeles")
cbind(US=format(t1),UK=format(t1,tz="Europe/London"))
      