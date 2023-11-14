test_that("Prediction works", {
  dataset = LinearModelGenerator::data
  model_package = generate_linear_model(Depression~Age+Sex+Fatalism,dataset)
  model_lm = lm(Depression~Age+Sex+Fatalism,dataset)
  #test 1
  new_X <- data.frame(Age = c(15, 29, 34), Sex = c(1, 0, 1), Fatalism = c(2, 0, 5))
  predict_true <- predict(model_lm, newdata = new_X)
  predict = get_pred(model_package,new_X)
  expect_equal(predict, as.matrix(predict_true),check.attributes = FALSE)
  #test 2
  new_X <- data.frame(Age = c(1, 23, 39), Sex = c(0, 0, 1), Fatalism = c(3, 9, 10))
  predict_true <- predict(model_lm, newdata = new_X)
  predict = get_pred(model_package,new_X)
  expect_equal(predict, as.matrix(predict_true),check.attributes = FALSE)
  #test 3
  new_X <- data.frame(Age = c(84, 24, 74), Sex = c(1, 1, 1), Fatalism = c(13, 6, 12))
  predict_true <- predict(model_lm, newdata = new_X)
  predict = get_pred(model_package,new_X)
  expect_equal(predict, as.matrix(predict_true),check.attributes = FALSE)
})
