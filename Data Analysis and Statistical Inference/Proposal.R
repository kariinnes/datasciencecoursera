#Download health data from NY.gov 
download.file(url = "https://health.data.ny.gov/api/views/es3k-2aus/rows.csv",  destfile = "./weightdata.csv", method = "curl")
weightdata <- read.csv("./weightdata.csv", colClasses = "character")
head(weightdata)
names(weightdata)
#are middle/high school children more overweight/obese on average than elementary children [use variables PCT.OVERWEIGHT.OR.OBESE (numerical) and GRADE.LEVEL (categorical)]?

weightdata$Pct_OverweightObese <- as.numeric(sub("%", "", weightdata$PCT.OVERWEIGHT.OR.OBESE))

#Boxplot of percentages overweight/obese for each grade level
png(filename = "boxplot_weight.png",
    width = 480, height = 480)
boxplot(weightdata$Pct_OverweightObese ~ weightdata$GRADE.LEVEL, col = "blue")
dev.off()

#Plot percentages overweight/obese by grade level
library(ggplot2)
png(filename = "qplot_weight.png",
      +     width = 480, height = 480)
plot <- qplot(Pct_OverweightObese, data = weightdata, binwidth = 10, facets = . ~ GRADE.LEVEL, color = GRADE.LEVEL, xlab = "Percent Overweight/Obese")
plot
dev.off()

#Histogram of percentage overweight/obese
hist(weightdata$Pct_OverweightObese, xlab = "Percent Overweight/Obese")

#Calculate mean for each grade level
mean_byLevel <- aggregate(Pct_OverweightObese ~ GRADE.LEVEL, weightdata, FUN = "mean")

##NEED GRADE LEVEL to be a factor for this function
###mean_byLevel2 <- by(weightdata$Pct_OverweightObese, weightdata$GRADE.LEVEL, mean)

median_byLevel <- aggregate(Pct_OverweightObese ~ GRADE.LEVEL, weightdata, FUN = "median")

x<- summary(weightdata$Pct_OverweightObese)

#Sample from the data
x <- head(weightdata,25)
write.table(x, file = "sampleData.txt")

#____________________________________________________________
#Calculate standard deviation for each grade level
sd_byLevel <- aggregate(Pct_OverweightObese ~ GRADE.LEVEL, weightdata, FUN = "sd")

#Ho: meanMiddleHigh = meanElementary
#Ha: meanMiddleHigh > meanElementary

#Subset data for variables of interest only
subset_weightData <- data.frame(middleHigh = numeric(745), elementary = numeric(745))

subset_weightData[,1] <- subset(weightdata, GRADE.LEVEL == "MIDDLE/HIGH", select = Pct_OverweightObese)

subset_weightData[,2] <- subset(weightdata, GRADE.LEVEL == "ELEMENTARY", select = Pct_OverweightObese)

#Histograms of the percentages- separate by grade level
hist(subset_weightData$middleHigh)
hist(subset_weightData$elementary)

###T-test?  sample size is large so really want Z statistic
#one-sided test since want Ha of "greater than" and not "not equal"
t.test(subset_weightData$middleHigh, subset_weightData$elementary, paired = FALSE, conf.level = 0.975)


