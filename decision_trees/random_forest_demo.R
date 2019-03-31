  # Random Forest Demo

  # removes all objects and functions from the global environment
  rm(list = ls())
  
  # load packages
  library(caret)
  library(rpart)
  library(rpart.plot)
  library(randomForest)
  library(ggplot2)
  
  # Load data
  college <- read.csv("data/college.csv", header = TRUE, stringsAsFactors = TRUE)
  
  # Keep only complete observations and drop the first column - "University Name"
  college <- college[complete.cases(college), c(2:19)]   
  # examine structure of the college dataframe
  str(college)  

  # Create formula
  college_formula <- as.formula(paste0(paste((names(college)[1]), collapse = " + "),
                                       "~", paste0((names(college)[2:18]), 
                                                   collapse = " + ")))
  
  # Decision tree with a max-depth of five
  dtree_fit <- train(college_formula, data = college, method = "rpart", 
                     control = list(maxdepth = 5), 
                     trControl =  trainControl(method = "cv", number = 3))  
  
  # Cross-validation results
  dtree_fit$resample[ ,c(1,3)]
  
  # Visualize the decision tree 
  rpart.plot(dtree_fit$finalModel)
  
  # Extracting variable importance
  dtree_VarImp <- varImp(dtree_fit)
  dtree_VarImp <- dtree_VarImp$importance
  dtree_VarImp$variables <- (rownames(dtree_VarImp))
  dtree_VarImp <- dtree_VarImp[order(dtree_VarImp$Overall, decreasing = TRUE), ]
  
  # Visualizing variable importance
  ggplot(dtree_VarImp, aes(x = reorder(variables, Overall), y = Overall)) +
    geom_bar(stat = "identity") + 
    coord_flip() +
    theme_bw() +
    labs(title="Variables Importance - Decision Tree with Max Depth of 5",
         x ="Variables", y = "Variable Importance")

  set.seed(0)
  # Random Forest
  rf_fit <- train(college_formula, data = college, method = "rf",  ntree = 1000, 
                  trControl =  trainControl(method = "cv", number = 5))  
  
  # Results of the cross-validation
  rf_fit$resample[ , c(1,3)]
  
  # Variable importance
  varImp(rf_fit)
  