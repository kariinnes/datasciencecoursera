#Part 1
###simulated 40 exponential(0.2)s with lambda = 0.2  
lambda = 0.2
exponentials = 40
n = 1000

simulatedData <- matrix(0,nrow=n,ncol=exponentials)
testResults <- data.frame(mean = numeric(0), sd = numeric(0), lowerCI = numeric(0), upperCI = numeric(0), coverageTest = numeric(0))

for (i in 1:n) 
{
        simulatedData[i,] <- rexp(exponentials,lambda)
        testResults[i,1] <- mean(simulatedData[i,])
        testResults[i,2] <- sd(simulatedData[i, ])
        testResults[i,3] <- testResults$mean[i] - 1 * 1.96 * testResults$sd[i] / sqrt(exponentials)
        testResults[i,4] <- testResults$mean[i] + 1 * 1.96 * testResults$sd[i] / sqrt(exponentials)
        testResults[i,5] <- testResults$lowerCI[i] <= 5 & 5 <= testResults$upperCI[i]
        
}

length(testResults$coverageTest[testResults$coverageTest==1])

###The expected value of an exponentially distributed random with rate parameter λ is given by
#1/λ; with λ = 0.2 the hypothetical mean is 5.0000

###mean of 1000 simulations of 40 exponential(0.2)s
mean(testResults$mean)

###This compares to the mean of exponential distribution of = 1/lambda, or
(1/lambda)

###standard deviation of the mean of 40 exponential(0.2)s
sd(testResults$mean)

###This compares to the standard deviation of an exponential distribution = 1/lambda
(1/lambda)/sqrt(40)

###distribution of the mean of 40 exponential(0.2)s
hist(testResults$mean)

#Part 2
###load Tooth Growth dataset
data(ToothGrowth)
str(ToothGrowth)
head(ToothGrowth)

###Plot length by dose - color coded by supp
library(ggplot2)
qplot(ToothGrowth$dose, ToothGrowth$len, color = ToothGrowth$supp)

##Calculate mean length for each supp
mean_bySupp <- aggregate(len ~ supp, ToothGrowth, FUN = "mean")

###Calculate mean length for each dose
mean_byDose <- aggregate(len ~ dose, ToothGrowth, FUN = "mean")


