---
title       : Exploring the IBM HR Data
subtitle    : Coursera Developing Data Products Pitch - Week 4
author      : Simon C
job         : 
dte         : Apr 21, 2017
framework   : io2012   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---  .myRed

## Introduction 
This presentation sets out my pitch for a Shiny App that explores data the IBM HR Analytics dataset.  This is a fictional dataset provided by IBM scientists and hosted by Kaggle [here](https://www.kaggle.com/pavansubhasht/ibm-hr-analytics-attrition-dataset).  The dataset enables an exploration of the features that might predict why someone would leave the company.


This app is great as it might help you stop your employees leaving!
In this pitch you will get to:

+ See some exploratory graphs
+ Link to the Shiny app that supports this pitch

--- .smallCode

## Lower Paid People Might Go!
The data shows a strong skew towards lower paid employees for both men and women, and with very similar proportions in the payscale.


```r
HR <- read.csv('../../DDP-WK4-SHINY/IBMHR.csv')
HR <- HR %>% select(-(EmployeeCount:EmployeeNumber)) %>%
  mutate(SalaryBand= cut2(MonthlyIncome, g=5))

q <- ggplot(data=HR,aes(x=MonthlyIncome), xlab="Monthly income") + geom_density(aes(fill=Attrition),alpha=.4)+ facet_grid(. ~ Gender)
q
```

<img src="figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />


--- .smallCode

## What about job types?
We can also see the distribution of job types in the dataset.


```r
q <- ggplot(data=HR,aes(x=JobRole), xlab="Job Role") + geom_bar (aes(fill=SalaryBand))+ facet_grid(. ~ Gender)+coord_flip()
q
```

<img src="figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />


---

## The prediction Shiny model

A Random Forest is often a very robust approach.  I have therefore developed a shiny app that enables the user to explore the number of trees grown and the impact on the confusion matrix.

The model can be found [here](https://simbosky.shinyapps.io/ddp-wk4/)

---
## The outcome

The prediction model shows the following: 

+ The forest will predict correctly a full training set with only around 40 trees.
+ At this number of trees, the test set accuracy is approximately 85%
+ Increasing the number of trees to 100 only increases the test set accuracy to 85.68%
+ Increasing the number of trees to 500 does not further increase the accuracy beyond 85.68%

Pretty good - you should use it!!
