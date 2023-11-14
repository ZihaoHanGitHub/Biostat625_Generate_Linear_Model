
test_that("Main Function Work", {
  #coefficient table test
  dataset = LinearModelGenerator::data
  model_package = generate_linear_model(Depression~Age+Sex+Fatalism,dataset)
  model_lm = lm(Depression~Age+Sex+Fatalism,dataset)
  summary_lm = summary(model_lm)
  coefficient_table = model_package$coefficients_table
  coefficients = coefficient_table[,c("Estimate","Std. Error", "t value", "Pr(>|t|)")]
  coefficients = as.matrix(coefficients)
  Significant = coefficient_table[,"Significance"]
  Significant_true <- c("***","***","  ","***")
  expect_equal(coefficients, summary_lm$coefficients)
  expect_equal(Significant, Significant_true)
  # Rsquared_table test
  R_squared_table = model_package$Rsquared_table
  R_squared_package = R_squared_table$R_squared
  Adjusted_R_squared_package = R_squared_table$Adjusted_R_squared
  R_squared_lm = summary_lm$r.squared
  adj_r_squared_lm <- summary_lm$adj.r.squared
  expect_equal(R_squared_package, R_squared_lm)
  expect_equal(Adjusted_R_squared_package, adj_r_squared_lm)
  # Sum of Square table test
  SS_table = model_package$SS_table
  SS = SS_table$SS
  residuals_lm <- residuals(model_lm)
  SSE_lm = sum(residuals_lm^2)
  mean_y = mean(dataset$Depression)
  SSY_lm = sum((dataset$Depression - mean_y)^2)
  SSR_lm =SSY_lm - SSE_lm
  SS_lm = c(SSR_lm,SSE_lm,SSY_lm)
  expect_equal(SS, SS_lm)
  df = SS_table$df
  dfE = df.residual(model_lm)
  dfY = nrow(dataset)-1
  dfR = dfY - dfE
  df_true = c(dfR,dfE,dfY)
  expect_equal(df, df_true)
  MS = SS_table$MS
  MSE = SSE_lm/dfE
  MSR = SSR_lm/dfR
  MSY = SSY_lm/dfY
  MS_true = c(MSR,MSE,MSY)
  expect_equal(MS, MS_true)
  # F table check
  F_table = model_package$F_table
  F_table_sub = F_table[,c("value","numdf","dendf")]
  F_table_sub = as.matrix(F_table_sub)
  #F_table_sub = as.matrix(F_table_sub)
  #F_statistics = F_table$F_statistics
  p_value = F_table[,"p_value"]
  F_table_true <- summary(model_lm)$fstatistic
  f_test_result <- anova(model_lm)
  p_value_true <- f_test_result$"Pr(>F)"[1]
  expect_equal(t(F_table_sub), as.matrix(F_table_true))

  # confident_interval tetst
  CI = model_package$confident_interval
  lower_bond = CI[, 1]
  upper_bond = CI[, 2]
  conf_interval_true <- confint(model_lm)
  lower_true = conf_interval_true[, 1]
  lower_bond = as.matrix(lower_bond)
  upper_bond = as.matrix(upper_bond)
  upper_true = conf_interval_true[, 2]
  rownames(lower_bond) = c("(Intercept)","Age","Sex","Fatalism")
  rownames(upper_bond) = c("(Intercept)","Age","Sex","Fatalism")
  expect_equal(lower_bond, as.matrix(lower_true))
  expect_equal(upper_bond, as.matrix(upper_true))




  # test special cases,
  #empty formula
  warning = generate_linear_model(" ",dataset)
  expect_equal(warning,"Error! You enter an not valid argument!")
  #check n-p (dfE)
  # generate a data.frame of 1*3
  wrongdata = data.frame(
    Y=c(1),
    X1=c(2),
    X2=c(5)
  )
  warning = generate_linear_model(Y~X1+X2,wrongdata)
  expect_equal(warning, "Error!The data rows is not enough to calculate the parameter!")
  # check full rank
  #generate a data frame of not funn rank
  wrongdata = data.frame(
    Y=c(1,2,3,4,5,6),
    X1=c(1,1,1,1,1,1),
    X2=c(1,1,1,1,1,1)
  )
  warning = generate_linear_model(Y~X1+X2,wrongdata)
  expect_equal(warning,"Error!Check your dependent Variable, it is not full rank!")
  #check N.A in dataset
  #generate a dataset contains N.A
  wrongdata <- data.frame(
    Y = c(1, 2, 3, NA, 5, 6),
    X1 = c(4, 1, 1, 2, 4, 1),
    X2 = c(1, 9, 1, 1, 5, 1)
  )
  warning = generate_linear_model(Y~X1+X2,wrongdata)
  expect_equal(warning,"Error! Your dataset contains N.A!")
  #check all the variables contain in dataset
  wrongdata <- data.frame(
    Y = c(1, 2, 3, 0, 5, 6),
    X1 = c(4, 1, 1, 2, 4, 1),
    X2 = c(1, 9, 1, 1, 5, 1)
  )
  warning = generate_linear_model(Y~X1+X2+X3,wrongdata)
  expect_equal(warning,"Error: Not all variables in variable_vector are present in the data.")

  # continue test significance
  model_sigtest1 = generate_linear_model(Depression~Sex,data=data)
  coefficients_table = model_sigtest1$coefficients_table
  significance = coefficients_table$Significance
  Significant_true <- c("***",".")
  expect_equal(significance,Significant_true)

  #continue test significance
  model_sigtest1 = generate_linear_model(Sex~ Fatalism, data)
  coefficients_table = model_sigtest1$coefficients_table
  significance = coefficients_table$Significance
  Significant_true <- c("***","*")
  expect_equal(significance,Significant_true)

  #continue test significance

})

