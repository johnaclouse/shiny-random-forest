# ui.R
library(shiny)
source('model.r')

shinyUI(fluidPage(
  titlePanel("Interactive Model (Risk of Diabetes)"),
  
  sidebarLayout(
    sidebarPanel(
      p("Shiny Demo App"),
      
      numericInput(
        'pregnant',
        'Pregnancies',
        value = mean(test.data$pregnant),
        min = min(test.data$pregnant),
        max = max(test.data$pregnant)
      ),
      numericInput(
        'glucose',
        'Plasma glucose',
        value = mean(test.data$glucose),
        min = min(test.data$glucose),
        max = max(test.data$glucose)
      ),
      numericInput(
        'pressure',
        'Diastolic pressure',
        value = mean(test.data$pressure),
        min = min(test.data$pressure),
        max = max(test.data$pressure)
      ),
      numericInput(
        'triceps',
        'Tricep skin fold thickness',
        value = mean(test.data$triceps),
        min = min(test.data$triceps),
        max = max(test.data$triceps)
      ),
      numericInput(
        'insulin',
        '2 hour serum insulin',
        value = mean(test.data$insulin),
        min = min(test.data$insulin),
        max = max(test.data$insulin)
      ),
      numericInput(
        'mass',
        'Body mass index',
        value = mean(test.data$mass),
        min = min(test.data$mass),
        max = max(test.data$mass)
      ),
      numericInput(
        'pedigree',
        'Diabetes pedigree function',
        value = mean(test.data$pedigree),
        min = min(test.data$pedigree),
        max = max(test.data$pedigree)
      ),
      numericInput(
        'age',
        'Patient Age',
        value = mean(test.data$age),
        min = min(test.data$age),
        max = max(test.data$age)
      )
    ),
    
    mainPanel(h3(textOutput(
      "predicted_diabetes"
    )),
    
    p(style= 'padding-bottom: 20px'),
    
    hr(),
    
    p(style= 'padding-bottom: 20px'),
    plotOutput("roc_plot"),
    plotOutput('explainer')
    
    )
    
  )
  
  
))
