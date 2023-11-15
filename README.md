# LinearModelGenerator
<!-- badges: start -->
[![R-CMD-check](https://github.com/ZihaoHanGitHub/Biostat625_Generate_Linear_Model/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ZihaoHanGitHub/Biostat625_Generate_Linear_Model/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/ZihaoHanGitHub/Biostat625_Generate_Linear_Model/graph/badge.svg?token=2X8Z7I7TPR)](https://codecov.io/gh/ZihaoHanGitHub/Biostat625_Generate_Linear_Model)

<!-- badges: end -->
This packages is design for the simple and multiple linear regression model, it contains a dataset about depression, a main functino to fit your model, a function to using your model that is fitted by the main function to predict or calculate on the new dataset.
#Installation
You can use the command of devtools and github link to install this packages,
```
devtools::install_github(ZihaoHanGitHub/Biostat625_Generate_Linear_Model)
```
After the packages download, you can using the library to use this package!
```
library(LinearModelGenerator)
```
After the code complete, you can start to use this function!
#GenerateLinearModel
In this packages,it contains two function, and one dataset, this section is introduce the usage of these two functions, especially the input and output.
generatorLinearModel is the functino help you to fitted your simple/multiple regression model by Least Squared Estimate.
##INPUT:
###S:
A string, it is defined as a formula formatt, containing your response variable and dependent variables, example formatt:"Y~X1+X2+X3"
###Dataset:
A dataset containing all the variable you mentioned in your *S* (linear model formula), recommended do not containing *N.A*, and the length of each variable should be same.
##OUTPUT
The function would return a data frame contain several information about your model.
### 0.Mathematics Formula:
- *Mathematics express:* The model mathematics express.
### 1. Coefficient Table:
- **Description:** Most of your model's coefficients are saved in this data frame.
- **Estimate:** Parameter estimates obtained through the Least Squared Estimate.
- **Std. Error:** Standard Error of the estimated parameters.
- **t value:** The t-value of each parameter, testing against the null hypothesis $\beta = 0$.
- **Pr(>|t|):** P-value of each test, calculated with the degree of freedom $n-p$.
- **Significance:** Significance level indicators: $.$ (under 0.1), $*$ (under 0.05), $**$ (under 0.01), $***$ (under 0).

### 2. Rsquared Table:
- **Description:** Calculates $R^2$ and adjusted $R^2$.
- **$R^2$:** Proportion of variance in Y explained by the data.
- **$adj R^2$:** Adjusted $R^2$ to prevent non-decreasing by adding dependent variables.

### 3. A Sum of Sq. Table:
- **Description:** Contains SSR, SSE, SSY, with degrees of freedom and mean squared values.
- **SS:** Table with SSR, SSE, SSY.
- **df:** Degrees of Freedom (dfR, dfE, dfY).
- **MS:** Mean Squared values (MSR, MSE, MSY).

### 4. F Table:
- **Description:** Contains F-statistics, degrees of freedom 1 and 2, and p-value.
- **value:** F-statistics of your model.
- **numdf:** First degree of freedom of the F test.
- **dendf:** Second degree of freedom of the F test.
- **p_value:** P-value of the F-test.

### 5. Confident Interval:
- **Description:** DataFrame of 95% confidence intervals for each parameter.
- **confident interval lower:** Lower bound of the 95% CI.
- **confident interval upper:** Upper bound of the 95% CI.
#get_pred
This functino is help you to calculate the prediction or new dataset for the model you already fitted by the function aboved.
##INPUT
### Model:
The model you fitted by the function generateLinearModel, directly input to get_pred function, you do not need to adjusted this input.
###New Dataset:
The dataset you want to caluclate or predict, containing all the dependents variables are needed.

##OUTPUT:
### Vector of new reponse variables:
The functino would return a vector, which is the response variables calculated by the model and dataset you input to this model, each row corresponding to the original row of dataset.

# Example for Usage of this package
First of all, you can use the dataset provided by the packages, this is a dataset about depression, with four vairbales, Depression, Age, Sex, and Fatalism
```
dataset = LinearModelGenerator::data
```
Now, we fit a model, with the formula $Depression = \beta_0 + \beta_1 * Age + \beta_2 * Sex + \beta_3 * Fatalism$

```
model =  generate_linear_model(Depression~Age+Sex+Fatalism,dataset)
```
As the code finish running, you can call out every table you want,
Call the coefficient table
```
model$coefficients_table
```
Call the the mathematics formula
```
model$Mathematics_formula
```
Call the R squared table
```
model$Rsquared_table
```
Call the Sum of Square Table
```
model$SS_table
```
Call the F-test Table
```
model$F_table
```
Call the 95% Confidence Interval
```
model$confident_interval
```
This is all of the output inside the generateLinearModel functino return, and next is the usage of get_pred,
first, prepare the new dataset of the Age, Sex, and Fatalism, that you want to predict,
```
new_X <- data.frame(Age = c(15, 29, 34), Sex = c(1, 0, 1), Fatalism = c(2, 0, 5))
```
And your model is the output of generatreLinearModel, thus you can directly input to get_pred function
```
new_Y <- get_pred(model,new_X)
```
Thus, the value of new_Y is corresponding to the new_X that you input!
   
   
   
   
   
   
