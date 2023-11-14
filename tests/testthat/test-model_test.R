
test_that("Main Function Work", {
  #coefficient table test
  dataset = LinearModelGenerator::data
  model_package = generate_linear_model(Depression~Age+Sex+Fatalism,dataset)
  model_lm = lm(Depression~Age+Sex+Fatalism,dataset)
  summary_lm = summary(model_lm)
  coefficient_table = model_package$coefficients_table
  expect_equal(coefficient_table, summary_lm$coefficients)

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
  #F_statistics = F_table$F_statistics
  p_value = F_table[,"p_value"]
  F_table_true <- summary(model_lm)$fstatistic
  f_test_result <- anova(model_lm)
  p_value_true <- f_test_result$"Pr(>F)"[1]
  expect_equal(F_table_sub, F_table_true)

  # confident_interval tetst
  CI = model_package$confident_interval
  lower_bond = CI[, 1]
  upper_bond = CI[, 2]
  conf_interval_true <- confint(model_lm)
  lower_true = conf_interval_true[, 1]
  upper_true = conf_interval_true[, 2]
  expect_equal(lower_bond, lower_true)
  expect_equal(upper_bond, upper_true)

})

