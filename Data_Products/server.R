require(shiny)
require(ggplot2)
require(rpart)

limitedDiamonds <<- diamonds[, c(1:4,7)]

set.seed(556)   

modelFit <<- rpart(price ~ cut + carat + color + clarity, data=limitedDiamonds)

inputData <<- limitedDiamonds[1,]

shinyServer(
        function(input, output, session) {
          
                #new data frame to apply prediction model
                finalData <- reactive ({
                inputData$carat <- as.numeric(input$carat)
                inputData$cut <- ordered(as.factor(input$cut), levels = c("Fair", "Good", "Very Good", "Premium", "Ideal"))
                inputData$color <- ordered(as.factor(input$color), levels = c("D", "E", "F", "G", "H", "I", "J"))
                inputData$clarity <- ordered(as.factor(input$clarity), levels = c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"))
                inputData$price <- as.integer(0)
                inputData 
                })
                
                pricePrediction <- reactive({predict(modelFit, finalData())})

    output$prediction <- renderPrint({pricePrediction()})
    output$carat <- renderPrint({input$carat})
    output$cut <- renderPrint({input$cut})
    output$color <- renderPrint({input$color})
    output$clarity <- renderPrint({input$clarity})
  }
)





