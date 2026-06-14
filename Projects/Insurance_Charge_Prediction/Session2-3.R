library(corrplot)
## Set Working Directory
setwd("~/Desktop/MLWBA")
## Import Dataset
insurance = read.csv("insurance_LR1.csv")
summary(insurance)
View(insurance)
insurance = read.csv("insurance_LR1.csv",stringsAsFactors = TRUE)
View(insurance)
summary(insurance)
## convert into Categorical Data
insurance$children = as.factor(insurance$children)
insurance = na.omit(insurance)
## Step 2: Create Dummy Variable
## install.packages("fastDummies")
library(fastDummies)
insurance = dummy_cols(insurance, select_columns = c ("sex", "region"))
## label encoding
insurance$smoker = ifelse (insurance$smoker=="yes",1,0)
## Step 3: Correlation
cr = cor(insurance[c("age","bmi","sex_male","smoker","region_northeast","region_northwest",
                     "region_southeast","region_southwest","charges")])
cr
corrplot.mixed(cr)
corrplot(cr,type = "full")
corrplot(cr,method = "number")
## help
?corrplot
## Step 4: Training & Testing (to do prediction)
## install.packages("caTools")
library(caTools)
set.seed(111)
split = sample.split(insurance$charges, SplitRatio = 0.85)
training_data = subset(insurance,split == "TRUE")
testing_data = subset(insurance,split == "FALSE")
View(training_data)
View(testing_data)
                    ## Note ##
## DV has to be normally distributed -> Hetero scarcity
## DV and IV must have correlation -> Insignificant Variable
## Two IV shouldn't be highly correlated -> Multicollinearity
library(psych)
pairs.panels(training_data[c("age","bmi","sex_male","smoker","charges")])
## Step 5:building the model on training dataset
model1 = lm(charges ~ age, data = training_data)
summary(model1)
model2 = lm(charges ~ age+bmi, data = training_data)
summary(model2)
## vif = 1/(1-R^2) {if vif > 5 -> Multicollinearity}
library(car)
vif(model2)
plot(model1$fitted.values,model1$residuals) ##funnal test
library(skedastic)
library(lmtest)
lmtest::bptest(model1)
lmtest::bptest(model2)
skedastic::white(model1)
skedastic::white(model2) ##heteroscarcity -> doesn't want
plot(model2$fitted.values,model2$residuals)

###
model3 = lm(charges ~ age+bmi+smoker, data = training_data)
summary(model3)
vif(model3)
plot(model3$fitted.values,model3$residuals)
lmtest::bptest(model3)
skedastic::white(model3)
###

## test the model on testing data ##
prediction = predict(model3,testing_data)
head(prediction)
head(testing_data$charges)
plot(testing_data$charges,type="l",col="red")
lines(prediction,type = "l", col="grey")

prediction1 = predict(model2,testing_data)
plot(testing_data$charges,type="l",col="yellow")
lines(prediction1,type = "l", col="cyan")

prediction2 = predict(model1,testing_data)
plot(testing_data$charges,type="l",col="yellow")
lines(prediction2,type = "l", col="cyan")

