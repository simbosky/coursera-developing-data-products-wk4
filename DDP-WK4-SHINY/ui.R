
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme=shinytheme("readable"),
  #shinythemes::themeSelector(),
  # Application title
  titlePanel("IBM HR Analytics Dataset"),
  fluidRow(column(width=12,
          h3("Training a Random Forest on the IBM HR Analytics Dataset"),
          p(em("Simon C -20th April 2017. Data provided by Kaggle"), a(href="https://www.kaggle.com/pavansubhasht/ibm-hr-analytics-attrition-dataset", "here")),
          p("This is a fictional dataset provided by IBM scientists to examine the factors that lead to employee attrition.
            The data has been split into train and test. The train size is:",textOutput("trainSize")),
          p("The Random Forest package in Caret is used to train a prediction model.  You can vary the number of trees grown using the slide."),
          p("You can view either the plot of Variable Importance or the confusion matrices.  You can choose how many variables are shown in the plot.")
          
                  )),
  
  fluidRow(
    column(width=6,
    sliderInput("ntree",
                "Number of Trees:",
                min = 1,
                max = 100,
                step = 5,
                value = 5)),
  column(width=6,numericInput("top",label="Number of Variables",value=10, min=1, max=20, step=5, width="100%")),

    fluidRow(column(width=12,navlistPanel(  
      # Show a plot of the generated distribution
      tabPanel("Variable Importance Plot",fluidRow(column(width=12, plotOutput("fitRF")))),
      tabPanel("Train Confusion Matrix",fluidRow(column(width=12, verbatimTextOutput("fitConfusion")))),
      tabPanel("Test Confusion Matrix",fluidRow(column(width=12, verbatimTextOutput("testConfusion"))))
    )))
    
    )
  
))
