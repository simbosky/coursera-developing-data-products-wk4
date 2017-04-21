

library(shiny)
library(dplyr)
library(caret)
library(randomForest)
library(reshape2)
library(e1071)

#setwd('~/Desktop/coursera/Assignments/DDP/DDP-WK4/DDP-WK4')
#import data
set.seed(4343)
HR <- read.csv('IBMHR.csv')
HR <- HR %>% select(-(EmployeeCount:EmployeeNumber))
trainIndex <- createDataPartition(HR$Attrition, list = FALSE, p=0.7)
trainX <- HR[trainIndex,] %>% select(-Attrition)
trainY <- HR[trainIndex,] %>% select(Attrition)
testX <- HR[-trainIndex,] %>% select(-Attrition)
testy <- HR[-trainIndex,] %>% select(Attrition)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  fitModel <- reactive({
    #randomForest(train$Attrition ~ ., data <- train, ntree=input$ntree, importance=TRUE )
    set.seed(123321)
    trControl <- trainControl(method="none")
    train(x=trainX, y=trainY[[1]], method="rf", ntree=input$ntree,
          importance=TRUE, trControl = trControl,tuneLength =1 )
    })
  
  output$fitRF <- renderPlot({plot(varImp(fitModel()), top=input$top, main = paste0("Number of trees used is ",input$ntree))})
  
  output$fitConfusion <- renderPrint({
    confusionMatrix(predict(fitModel(), newdata=trainX),trainY[[1]])
    })
  
  output$testConfusion <- renderPrint({
    confusionMatrix(predict(fitModel(), newdata=testX),testy[[1]])
  })
  
  output$trainSize <- renderText({ paste0(
    "Observations: ",dim(trainX)[1],", Predictors: ",dim(trainX)[2])})
  
})
