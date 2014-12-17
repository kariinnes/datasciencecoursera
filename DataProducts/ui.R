library(shiny)

# Define UI for dataset viewer application
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Diamond Price Prediction"),
  
    #inputs
    sidebarPanel(
      p('Enter carat size between 0 and 5.0'),
      numericInput('carat', 'Enter Carat Size', 0.5, min = 0, max = 5, step = .01),
      selectInput('cut',
                  label = "Choose Cut",
                  choices = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                  selected = "Very Good"),
      selectInput('color',
                  label = "Choose Color",
                  choices = c("D", "E", "F", "G", "H", "I", "J"),
                  selected = "F"),
      selectInput('clarity',
                  label = "Choose Clarity",
                  choices = c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"),
                  selected = "SI1"),
      #submitButton('Submit'),
      h3('Documentation'),
      p("This project uses the diamonds dataset to predict",
      "the price of a diamond based on input carat size, cut,",
      "color and clarity.")),
    mainPanel(
        h3("Results of prediction"),
        h4("The predicted price of the diamond is"),
        verbatimTextOutput("prediction"),
        p("based on a carat size of"),
        verbatimTextOutput("carat"),
        p("and cut"),
        verbatimTextOutput("cut"),
        p("and color"),
        verbatimTextOutput("color"),
        p("and clarity"),
        verbatimTextOutput("clarity"),
        h3('Note'),
        p("Please be patient when you first enter the site.  The",
          "regression model needs to be built initially and takes",
          "about 2 minutes.  Once that occurs, each time you update",
          "the inputs the response will be immediate.")
        
    )
  )
)




 
