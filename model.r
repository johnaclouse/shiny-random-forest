library(tidyverse)
library(caret)
library(randomForest)
library(plotROC)

# Load the data and remove NAs
data("PimaIndiansDiabetes2", package = "mlbench")
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)
# Inspect the data
sample_n(PimaIndiansDiabetes2, 3)
# Split the data into training and test set
set.seed(123)
training.samples <- PimaIndiansDiabetes2$diabetes %>% 
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- PimaIndiansDiabetes2[training.samples, ]
test.data <- PimaIndiansDiabetes2[-training.samples, ]

# Fit the model on the training set
set.seed(123)
model <- train(
  diabetes ~., data = train.data, method = "rf",
  trControl = trainControl(method="cv", summaryFunction=twoClassSummary, classProbs=T,
                           savePredictions = T),
  importance = TRUE
)
# Best tuning parameter
model$bestTune


# Final model
model$finalModel

model

# Select a parameter setting
selectedIndices <- model$pred$mtry == 2

model_data <- model$pred[selectedIndices, ] 

roc_plot <- ggplot(model_data, aes(m=pos, d=factor(obs, levels = c("neg", "pos")))) +
  geom_roc(n.cuts = 10) +
  geom_rocci(ci.at = quantile(model_data$pos, c(0.2, 0.5, 0.8)), linetype = 1) +
  coord_equal() +
  style_roc(theme = theme_grey)

roc_plot <- roc_plot + annotate("text", x=0.75, y=0.25, label=paste("AUC =", round((calc_auc(g))$AUC, 4)))



# Make predictions on the test data
predicted.classes <- model %>% predict(test.data)
head(predicted.classes)

# Compute model accuracy rate
mean(predicted.classes == test.data$diabetes)


importance(model$finalModel)


# Plot MeanDecreaseAccuracy
varImpPlot(model$finalModel, type = 1)
# Plot MeanDecreaseGini
varImpPlot(model$finalModel, type = 2)

varImp(model)

plot(varImp(model))

# pregnant Number of times pregnant
# glucose Plasma glucose concentration (glucose tolerance test)
# pressure Diastolic blood pressure (mm Hg)
# triceps Triceps skin fold thickness (mm)
# insulin 2-Hour serum insulin (mu U/ml)
# mass Body mass index (weight in kg/(height in m)\^2)
# pedigree Diabetes pedigree function
# age Age (years)
# diabetes Class variable (test for diabetes)


head(test.data)
hist(test.data$age)

pregnant <- 1
glucose <- 130.1
pressure <- 70.1
triceps <- 30
insulin <-335
mass <- 30
pedigree <- 0.5
age <- 30.1

example.data <- 
  data.frame(
    pregnant,
    glucose,
    pressure,
    triceps,
    insulin,
    mass,
    pedigree,
    age
  )

 save(model, file = "model.rda")

# cat(predict(model, example.data, type = "prob")[[2]])
