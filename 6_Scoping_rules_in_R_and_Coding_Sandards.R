###Scoping Rules of R
##````````````````````````````````````````````````##

##A Diversion on Binding Values to Symbol
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
#How does R know which value to assign to which symbol? When I type
lm <- function(x) { x * x }
lm

#how does R know what value to assign to the symbol lm? Why doesn’t it give it the value of lm that
#is in the stats package?

#the order of search is found by using search()
search()

#If you load a package, it comes in the second position
library(dplyr)
search()

##Scoping Rules
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
#The scoping rules of a language determine how a value is associated with afree variable in a function.
#R uses lexical scopin or static scoping. An alternative to lexical scoping is dynamic scoping which
#is implemented by some languages. Lexical scoping turns out to be particularly useful for simplifying
#statistical computations
#Related to the scoping rules is how R uses the search list to bind a value to a symbol
#Consider the following function.
f <- function(x, y) {
  x^2 + y / z
}
#This function has 2 formal arguments x and y. In the body of the function there is another symbol
#z. In this case z is called a free variable.

#The scoping rules of a language determine how values are assigned to free variables.

#Free variables are not formal arguments and are not local variables (assigned insided the function body).
#Lexical scoping in R means that the values of free variables are searched for in the environment in which the function
#was defined.

#An environment is a collection of (symbol, value) pairs, i.e. x is a symbol and 3.14 might be its value.
#Every environment has a parent environment and it is possible for an environment to have multiple
#“children”. The only environment without a parent is the empty environment.
#A function, together with an environment, makes up what is called a closure or function closure.
#Most of the time we don’t need to think too much about a function and its associated environment
#(making up the closure), but occasionally, this setup can be very useful. The function closure model
#can be used to create functions that “carry around” data with them.


###Lexical Scoping: Why Does It Matter?
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬

#Below is a constructor functionthat can be used to make other functions
make.power<-function(n){
  pow<-function(x){
    x^n
  }
}

#create functions from make.power
square<-make.power(2)
cube<-make.power(3)

square(9)
cube(2)

cube
#Notice that cube() has a free variable n. What is the value of n here? 
#cube() function was defined as make.power(3), so the value of n at that time was 3.
#We can explore the environment of a function to see what objects are there and their values.
ls(environment(cube))
get("n", environment(cube))

square
ls(environment(square))
get("n", environment(square))
get("pow", environment(square))


###Lexical versus dynamic Scoping
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
y <- 10
f <- function(x){
  y <- 2
  y^2 + g(x)
}
g <- function(x){
  x*y
}

f(3)

#in lexical, f(3)=34
#With lexical scoping the value of y in the function g is looked up in the environment in which the
#function was defined, in this case the global environment, so the value of y is 10.
#With dynamic scoping, the value of y is looked up in the environment from which the function was called
#(sometimes referred to as the calling environment). In R the calling environment is known as the
#parent frame. In this case, the value of y would be 2.

#Python, Perl, scheme, common lisp all use lexical

###OPTIMISATION example
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬

#Optimization routines in R like optim(), nlm(), and optimize() require you to pass a function whose
#argument is a vector of parameters (e.g. a log-likelihood, or a cost function).

#Step 1. create a constructor function (negative log likelihood)
make.NegLoglik<-function(data, fixed=c(F,F)){
  params<-fixed
  function(p){
    params[!fixed]<-p
    mu<-params[1]
    sigma<-params[2]
    
    ##Calculate teh normal density
    a<- -0.5*length(data)*log(2*pi*sigma^2)
    b<- -0.5*sum((data-mu)^2)/(sigma^2)
    -(a+b)
  }
}
#Step 2. generate some data and constructuve the neg likelihood
set.seed(1)
normals<-rnorm(100,1,2)
head(normals)
nLL<-make.NegLoglik(normals)
nLL

#What is in nLL's environment

ls(environment(nLL))

#Now that we have our nLL() function, we can try to minimize it with optim() to estimate the parameters.
optim(c(mu=0, sigma=1), nLL)$par
#recall we used mean as 1 and sd as 2

#Now fix sigma to be 2
nLL<-make.NegLoglik(normals, c(F,2))
optimise(nLL, c(-1,3))$minimum

#Hold mu fixed at 1
nLL<-make.NegLoglik(normals, c(1,F))
optimise(nLL, c(1e-6,10))$minimum

##PLOTTING THE LIKELIHOOD
#Fix the mu to 1
nLL<-make.NegLoglik(normals, c(1,F))
x<-seq(1.7,1.9, len=100)
##evaluate nll at every point of x
y<-sapply(x, nLL)
plot(x, exp(-(y-min(y))),type="l")

##Fix sigma to 2
nLL<-make.NegLoglik(normals, c(F,2))
x<-seq(0.5, 1.5, len=100)
##evaluate nll at every point of x
y<-sapply(x, nLL)
plot(x, exp(-(y-min(y))),type="l")

##Summary
#¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
#• Objective functions can be “built which contain all of the necessary data for evaluating the function
#• No need to carry around long argument lists — useful for interactive and exploratory work.
#• Code can be simplified and cleaned up
#• Reference: Robert Gentleman and Ross Ihaka (2000). “Lexical Scope and Statistical Computing,” JCGS, 9, 491–508.
#

#
#
##

#
#
#
#

#
#
#
###Coding Standards for R
##````````````````````````````````````````````````##

#Always use text files / text editor. 
#Indent your code. Indenting is very important for the readability of your code.
#Limit the width of your code. I like to limit the width of my text editor so that the code I write
######doesn’t fly off into the wilderness on the right hand side. 
#Limit the length of individual functions. If you are writing functions, it’s usually a good idea to
#####not let your functions run for pages and pages. Typically, purpose of a function is to execute one
#####activity or idea. If your function is doing lots of things, it probably needs to be broken into multiple
#####functions.


