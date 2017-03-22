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
      
      