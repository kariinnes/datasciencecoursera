
#Load Data
stormdata <- read.csv("repdata_data_StormData.csv.bz2", header = TRUE)

str(stormdata)

#From the NOAA Storm Events Database, not all events were tracked until 1996.  I therefore removed observations prior to 1996 to make analysis consistent between the various events.  See  http://www.ncdc.noaa.gov/stormevents/details.jsp for a summary of the data discrepancies pre and post 1996.

timeAdjusted_data <- subset(stormdata, as.Date(stormdata$BGN_DATE, format = "%m/%d/%Y") >= "1996-01-01")  

subData <- timeAdjusted_data[,colnames(timeAdjusted_data) %in% c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG",  "CROPDMGEXP")] 

#I summed fatalities/injuries and property/crop damage.  I then ordered each of these totaled events to find the top 50 events to determine which
#categories to collapse exceptions: LANDSLIDE, STORM SURGE, SNOW SQUALL and DRY MICROBURST which are unclear on the correct category.  Each of these excluded events have fewer than 100 injuries/fatalities so will not imact the final result.  The final categories match 

subData$EVTYPE <- gsub("^thunderstorm.*|TSTM.*", "Thunderstorm", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("^flash flood.*", "Flash Flood", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub(".*flood.*|.*FLD", "Flood", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("Rip Current.*", "Rip Current", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("Wild.*", "WildFire", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub(".*Fog.*", "Dense Fog", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("glaze|.*ice.*", "Ice Storm", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("extreme.*", "Extreme Cold/Wind Chill", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("winter weather.*|wintry.*", "Winter Weather", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub(".*Surf.*", "High Surf", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub("hurricane.*|typhoon.*", "Hurricane/Typhoon", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub(".*frost|.*freeze", "Frost/Freeze", subData$EVTYPE, ignore.case = TRUE)
subData$EVTYPE <- gsub(".*wind.*", "Strong Wind", subData$EVTYPE, ignore.case = TRUE)

###Ensure all event types are lower case with capital first letter
lowerCap <- function(x) {
        s <- strsplit(x, " ")[[1]]
        paste(toupper(substring(s, 1,1)), tolower(substring(s, 2)),
              sep="", collapse=" ")
}

subData$EVTYPE <- sapply(subData$EVTYPE, lowerCap)

#Adjust crop and property damage to include exponential factors in *EXP variables.  Then delete *EXP variables from the data.

levels(subData$CROPDMGEXP)
levels(subData$PROPDMGEXP)

subData$CROPDMGEXP <- gsub("K|k", 1000, subData$CROPDMGEXP)
subData$CROPDMGEXP <- gsub("M|m", 1000000, subData$CROPDMGEXP)
subData$CROPDMGEXP <- gsub("B|b", 1000000000, subData$CROPDMGEXP)

subData$CROPDMG <- subData$CROPDMG * as.numeric(subData$CROPDMGEXP)
subData$CROPDMGEXP <- NULL

subData$PROPDMGEXP <- gsub("H|h", 100, subData$PROPDMGEXP)
subData$PROPDMGEXP <- gsub("K|k", 1000, subData$PROPDMGEXP)
subData$PROPDMGEXP <- gsub("M|m", 1000000, subData$PROPDMGEXP)
subData$PROPDMGEXP <- gsub("B|b", 1000000000, subData$PROPDMGEXP)

subData$PROPDMG <- subData$PROPDMG * as.numeric(subData$PROPDMGEXP)
subData$PROPDMGEXP <- NULL

#Sum fatalities and injuries to find the most harmful events with respect to population health

popHealth_data <- aggregate(FATALITIES + INJURIES ~ EVTYPE, subData, FUN = "sum")

colnames(popHealth_data) <- c("eventType", "incidentNumber")

#Remove rows with no injury or fatality incidents.  This is for the injury/fatality analysis only.  Rows to retain for the damages analysis is done separately

popHealth_data <- popHealth_data[popHealth_data$incidentNumber > 0, ]

popHealth_data_ordered <- popHealth_data[order(-popHealth_data[,2]),]

#Plot 10 Most Harmful Events with Respect to Population Health

library(ggplot2)
plot_health <- ggplot(popHealth_data_ordered[1:10,], aes(eventType, incidentNumber, fill=eventType))     
plot_health + geom_bar(stat="identity") +
labs(title = "Top 10 Most Harmful Events with Respect to Population Health") +
xlab("Events") +
ylab("Number of injuries and fatalities")  +
theme(axis.text.x=element_text(angle=45)) 

#Sum property and crop damages to find the events have the greatest economic consequences 

propDmg_data <- aggregate(PROPDMG + CROPDMG ~ EVTYPE, subData, FUN = "sum")

colnames(propDmg_data) <- c("eventType", "totalDamages")

#Remove rows with no property or crop damage.  This is for the property and crop damage analysis only.  Rows to retain for injuries and fatalities analysis is done separately.

propDmg_data <- propDmg_data[propDmg_data$totalDamages > 0, ]

propDmg_data_ordered <- propDmg_data[order(-propDmg_data[,2]),]

propDmg_data_ordered$totalDamages <- propDmg_data_ordered$totalDamages / 100000

rownames(propDmg_data_ordered) <- NULL

#Plot 10 Events with the Greatest Economic Consequences

plot_damages <- ggplot(propDmg_data_ordered[1:10,] , aes(eventType, totalDamages, fill=eventType))     
plot_damages + geom_bar(stat="identity") +
        labs(title = "Top 10 Events with Greatest Economic Consequences") +
        xlab("Events") +
        ylab("Total Damage")  +
        theme(axis.text.x=element_text(angle=-90)) 
