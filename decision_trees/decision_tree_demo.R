  # Decision Tree Demo

  # removes all objects and functions from the global environment
  rm(list = ls())
  
  # load packages
  library(datasets)
  library(caret)
  library(rpart)
  library(rpart.plot)
  
  # Basic Decision Tree
  df <- c()
  df$Y <- as.factor(c(0,1))
  df$x1 <- c(0,1)
  df$x2 <- c(0,1)
  df <- as.data.frame(df)
  
  # Fit the decision tree model
  dtree_fit_basic <- train(Y ~ x1 + x2, data = df, method = "rpart")
  dtree_fit_basic
  
  # Generate new samples/data
  df2 <- c()
  df2$x1 <- c(2.5, 2.5)
  df2$x2 <- c(0.3, 0.3)
  df2 <- as.data.frame(df2)
  
  # Predict with new samples
  dtree_pred_basic <- predict(dtree_fit_basic, newdata = )
  
  # load data from the datasets package
  data(iris)
  
  # analyze the structure of the iris dataframe
  str(iris)
  names(iris) <- tolower(names(iris))
  
  # create formula to use (similar to create a target array and feature matrix in R)
  iris_formula <- as.formula("species ~ sepal.length + sepal.width + 
                             petal.length + petal.width")
  # iris_formula <- as.formula(paste0(paste((names(iris)[5]), collapse = " + "), 
  #                                   "~", paste0((names(iris)[1:4]), 
  #                                               collapse = " + ")))
  
  set.seed(565)
  # Fit the decision tree model
  dtree_fit <- train(iris_formula, data = iris, method = "rpart")
  dtree_fit
  
  # Cross-validation
  trCtrl <- trainControl(method = "cv", number = 5)
  dtree_fit_cv <- train(iris_formula, data = iris, 
                        method = "rpart", trControl = trCtrl)
  
  # Results of the cross-validation
  dtree_fit_cv$resample[c(1,3)]
  
  # Visualize the decision tree 
  rpart.plot(dtree_fit_cv$finalModel)
  
  # Variable Importance
  varImp(dtree_fit)