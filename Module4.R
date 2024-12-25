library(readxl)
library(tidyverse)
library(ggplot2)
library(GGally)
library(e1071)
library(caret)
library(psych)

pumpkin_seeds <- read_excel("/Users/muhammadhassanzahoor/Desktop/ALY 6040/Module 4/Pumpkin_Seeds_Dataset.xlsx")

head(pumpkin_seeds)
colnames(pumpkin_seeds)
sum(is.na(pumpkin_seeds))

summary(pumpkin_seeds)
dim(pumpkin_seeds)
str(pumpkin_seeds)


describe_pumpkin <- describe(pumpkin_seeds)
describe_pumpkin

#Plotting distributions
ggplot(pumpkin_seeds, aes(x = Class)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Distribution of Classes", x = "Class", y = "Count")

#Scatterplot
ggplot(pumpkin_seeds, aes(x = Roundness, y = Compactness, color = Class)) +
  geom_point(alpha = 0.5) +
  labs(title = "Scatterplot of Roundness vs Compactness", x = "Roundness", y = "Compactness") +
  scale_color_manual(values = c("red", "blue"))


#Converting target variable
pumpkin_seeds$Class <- as.factor(pumpkin_seeds$Class)

levels(pumpkin_seeds$Class) <- make.names(levels(pumpkin_seeds$Class), unique = TRUE)

# Check the new levels
levels(pumpkin_seeds$Class)

#Splitting the data into trainig and tests sets
set.seed(123)
training_indices <- createDataPartition(pumpkin_seeds$Class, p = 0.8, list = FALSE)
train_data <- pumpkin_seeds[training_indices, ]
test_data <- pumpkin_seeds[-training_indices, ]

#Feature Scaling
preprocess_params <- preProcess(train_data[, -ncol(train_data)], method = c("center", "scale"))
train_data_scaled <- predict(preprocess_params, train_data)
test_data_scaled <- predict(preprocess_params, test_data)

#Train the SWM Model
svm_model <- svm(Class ~ ., train_data_scaled, kernel = "radial")

summary(svm_model)

# Make predictions
predictions <- predict(svm_model, test_data_scaled)

# Model accuracy
confusionMatrix(predictions, test_data_scaled$Class)


# Function to tune gamma and evaluate performance across different kernels
tune.gamma <- function(scale = 0.5) {
  Kernels <- c("linear", "polynomial", "radial", "sigmoid")
  gdv <- 1/12  # Default gamma value
  gDefault <- numeric(length(Kernels))  # Store default gamma results
  gLow <- numeric(length(Kernels))      # Store lower gamma results
  gHigh <- numeric(length(Kernels))     # Store higher gamma results
  
  # Loop through each kernel type and adjust gamma
  for (i in seq_along(Kernels)) {
    # Test default gamma
    temporary <- svm(Class ~ ., data = pumpkin_seeds, kernel = Kernels[i], gamma = gdv)
    tbl <- table(pumpkin_seeds$Class, predict(temporary))
    gDefault[i] <- sum(diag(tbl)) / sum(tbl)
    
    # Test gamma scaled down
    temporary <- svm(Class ~ ., data = pumpkin_seeds, kernel = Kernels[i], gamma = gdv - scale * gdv)
    tbl <- table(pumpkin_seeds$Class, predict(temporary))
    gLow[i] <- sum(diag(tbl)) / sum(tbl)
    
    # Test gamma scaled up
    temporary <- svm(Class ~ ., data = pumpkin_seeds, kernel = Kernels[i], gamma = gdv + scale * gdv)
    tbl <- table(pumpkin_seeds$Class, predict(temporary))
    gHigh[i] <- sum(diag(tbl)) / sum(tbl)
  }
  
  # Return a data frame of results for each kernel
  return(data.frame(Kernels, gLow, gDefault, gHigh))
}

# Execute gamma tuning
gamma_tuning_results <- tune.gamma(0.5)
print(gamma_tuning_results)












