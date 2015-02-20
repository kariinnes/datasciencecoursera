require(ggplot2)
require(randomForest)

limitedDiamonds <- diamonds[,c(1:4,7)]

testData <- limitedDiamonds[1:10,]

set.seed(556)
modelFit <- randomForest(price ~ ., data=limitedDiamonds)

modelFit

#user inputs
carat <- 0.23
cut <- "Good"
color <- "E"
clarity <- "SI2"
price <- 0
 
#new data frame to apply prediction model
inputData <- data.frame(matrix(ncol = 5, nrow = 1))
names(inputData) <- c("carat", "cut", "color", "clarity", "price")

inputData$carat <- as.numeric(carat)
inputData$cut <- ordered(as.factor(cut), levels = c("Fair", "Good", "Very Good", "Premium", "Ideal"))
inputData$color <- ordered(as.factor(color), levels = c("D", "E", "F", "G", "H", "I", "J"))
inputData$clarity <- ordered(as.factor(clarity), levels = c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"))
inputData$price <- as.integer(0)

pred <- predict(modelFit, inputData)
pred