#Load the Data
##Read in activity data (measured data)
activityData <- read.csv("activity.csv")

###Remove NAs from the data
activityData_NoNA <- activityData[complete.cases(activityData),]
row.names(activityData_NoNA) <- NULL

###Sum total steps for each day
library(plyr)
stepData <- ddply(activityData_NoNA,.(date), numcolwise(sum))

#What is mean total number of steps taken per day?
##Make a histogram of the total number of steps taken each day - Exclude NAs    
library(ggplot2)
plot_date <- ggplot(stepData, aes(steps))     
plot_date + geom_histogram(binwidth = 2800) + labs(title = "Total Steps for Each Day - No NAs")

##Calculate and report the mean and median total number of steps taken per day
mean <- mean(stepData$steps)
median <- median(stepData$steps)
        
#What is the average daily activity pattern?
##Mean of total steps per day across 5 minute intervals
intervalData <- activityData_NoNA
intervalData$date <- NULL
mean_intervalData <- aggregate(steps ~ interval, intervalData, FUN = "mean")

##Make a time series plot of the 5-minute interval and the average number of steps taken, averaged across all days 
mean_intervalData$interval <- as.numeric(mean_intervalData$interval)

plot_interval <- ggplot(mean_intervalData, aes(interval, steps))     
plot_interval + geom_line() + labs(title = "Average Steps for Each 5-minute Inteval")

##Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
max_interval <- mean_intervalData[mean_intervalData$steps == max(mean_intervalData$steps),]
row.names(max_interval) <- NULL

#Impute missing values
##Calculate total number of missing values in the dataset
activityData_NAs <- activityData[!complete.cases(activityData),]

##Fill in missing steps for NAs - set equal to mean total number of steps taken per day (broken into 5-minute interval)
mean_intervalData$interval <- factor(mean_intervalData$interval) 
activityData_NAs$interval <- factor(activityData_NAs$interval) 

activityData_NAs[, "steps"]  <-  
        mean_intervalData[activityData_NAs[, "interval"], "steps"]

##Create a new dataset that is equal to the original dataset but with the missing data filled 
activityData_total <- rbind(activityData_NoNA, activityData_NAs)

###Sum total steps for each day - total dataset
stepData_total <- ddply(activityData_total,.(date), numcolwise(sum))

##Make a histogram of the total number of steps taken each day - total dataset
plot_totaldata <- ggplot(stepData_total, aes(steps))     
plot_totaldata + geom_histogram(binwidth = 2800) + labs(title = "Total Steps for Each Day - Total Dataset")

##Calculate and report the mean and median total number of steps taken per day
mean_total <- mean(stepData_total$steps)
median_total <- median(stepData_total$steps)

#Are there differences in activity patterns between weekdays and weekends?
##Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day
activityData_total$dayType <- weekdays(as.Date(factor(activityData_total$date), format = "%Y-%m-%d"), abbreviate = FALSE)

for (i in 1:nrow(activityData_total)) {
     
if (activityData_total$dayType[i] %in% c("Saturday", "Sunday")) { 
        activityData_total$dayType2[i] <- "Weekend"
}
else {
        activityData_total$dayType2[i] <- "Weekday"
} 
}

activityData_total$dayType2 <- as.factor(activityData_total$dayType2)

##Make a time series plot of the 5-minute interval and the average number of steps taken, averaged across all weekday days or weekend days 
activityData_total$interval <- sprintf("%04d", as.numeric(activityData_total$interval))

#activityData_total$interval <- paste(substr(activityData_total$interval,1,2), substr(activityData_total$interval,3,4), sep = ":")

mean_dayTypeData <- aggregate(steps ~ dayType2 + interval, activityData_total, FUN = "mean")

plot_dayType <- ggplot(mean_dayTypeData, aes(x=interval, y=steps, group = dayType2, color = dayType2))     
plot_dayType + geom_line() + facet_grid(. ~ dayType2) + labs(title = "Average Steps for Each 5-minute Inteval by Weekend/Weekday")

