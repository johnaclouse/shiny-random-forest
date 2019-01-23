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
  
  output$explainer <- 
    renderPlot({
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
      
      explainer <- lime(test.data, model, n_bins = 5)
      
      explanation <- lime::explain(x = features,
                                   explainer = explainer,
                                   n_permutations = 5000,
                                   dist_fun = 'gower',
                                   kernel_width = .75,
                                   n_features = 8,
                                   feature_select = 'highest_weights',
                                   labels = 'pos')
      # explanation[, 2:9]
      
      plot_features(explanation, ncol = 1)
      
      
    })
  
  
})
