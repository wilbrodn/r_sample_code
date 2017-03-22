##Simulation##
##``````````##
#Generating Random Numbers
#~~~~~~~~~~~~~~~~~~~~~~~~~~#

#a need to introduce randomness.
#Sometimes you want to implement a statistical procedure that requires random number generation or samplie
##(i.e. Markov chain Monte Carlo, the bootstrap, random forests, bagging) and 
#sometimes you want to simulate a system and random number generators can be used to model random inputs.
#
###probability distributions in R
#• rnorm: generate random Normal variates with a given mean and standard deviation
#• dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or vector of points)
#• pnorm: evaluate the cumulative distribution function for a Normal distribution
#• rpois: generate random Poisson variates with a given rate

####For each probability distribution there are typically four functions:
#• d for density
#• r for random number generation
#• p for cumulative distribution
#• q for quantile function (inverse cumulative distribution)

####For normal distribution
#dnorm(x, mean = 0, sd = 1, log = FALSE)
#pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
#qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
#rnorm(n, mean = 0, sd = 1)

x<-rnorm(20)
x
summary(x)

x<-rnorm(20,4,2)
summary(x)
sd(x)

##Setting the random number seed##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

set.seed(1)
rnorm(5)
#Note that if I call rnorm() again I will of course get a different set of 5 random numbers.
rnorm(5)
#If I want to reproduce the original set of random numbers, I can just reset the seed with set.seed().
set.seed(1)
rnorm(5) ## Same as before

rpois(10, 1) ## Counts with a mean of 1
rpois(10, 2) ## Counts with a mean of 2

rpois(10, 20) ## Counts with a mean of 20


##Simulating a Linear Model##
##~~~~~~~~~~~~~~~~~~~~~~~~~##

## Always set your seed!
set.seed(20)
## Simulate predictor variable
x <- rnorm(100)
## Simulate the error term
e <- rnorm(100, 0, 2)
## Compute the outcome via the model
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

##Binary predictors
set.seed(10)
x <- rbinom(100, 1, 0.5)
str(x) ## 'x' is now 0s and 1s


e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
plot(x, y)


#Poisson distribution
set.seed(1)
## Simulate the predictor variable as before
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)


##Random Sampling##
##~~~~~~~~~~~~~~~~##
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)

## Doesn't have to be numbers
sample(letters, 5)

## Do a random permutation
sample(1:10)
sample(1:10)
## Sample w/replacement
sample(1:10, replace = TRUE)

library(datasets)
data(airquality)
head(airquality)

set.seed(20)
## Create index vector
idx <- seq_len(nrow(airquality))
## Sample from the index vector
samp <- sample(idx, 6)
airquality[samp, ]

##Summary##
##~~~~~~~##
#• Drawing samples from specific probability distributions can be done with “r” functions
#• Standard distributions are built in: Normal, Poisson, Binomial, Exponential, Gamma, etc.
#• The sample() function can be used to draw random samples from arbitrary vectors
#• Setting the random number generator seed via set.seed() is critical for reproducibility








