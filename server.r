# server.R
load('model.rda')

shinyServer(function(input, output) {
  output$roc_plot <- 
    renderPlot({roc_plot})
  
  
  output$predicted_diabetes <-
    renderText({
      features <- data.frame(
        pregnant = input$pregnant,
        glucose = input$glucose,
        pressure = input$pressure,
        triceps = input$triceps,
        insulin = input$insulin,
        mass  = input$mass,
        pedigree = input$pedigree,
        age = input$age
      )
      print(features)
      paste('Risk of diabetes:',
            predict(model, features, type = "prob")[[2]])
    })
  
  
})
