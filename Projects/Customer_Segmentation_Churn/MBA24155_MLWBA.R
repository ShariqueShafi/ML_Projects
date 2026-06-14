library(corrplot)
library(fastDummies)
setwd("~/Desktop/MLWBA")
dataset = read.csv("DataMLWBA_Cleaned.csv")
dataset$Amount.Requested = as.numeric(dataset$Amount.Requested)
dataset$Amount.Funded.By.Investors = as.numeric(dataset$Amount.Funded.By.Investors)
dataset$Revolving.CREDIT.Balance = as.numeric(dataset$Revolving.CREDIT.Balance)
dataset$Open.CREDIT.Lines = as.numeric(dataset$Open.CREDIT.Lines)
summary(dataset)
View(dataset)
dataset = dummy_cols(dataset,select_columns = c("Loan.Length","Loan.Purpose","Home.Ownership","Employment.Length"))
cr = cor(dataset[sapply(dataset,is.numeric)])
cr
corrplot.mixed(cr)
corrplot(cr,type = "full")
corrplot(cr,method = "number")
## Most corelated monthly income, loan leangth 60,loan leangth 30, house ownership, inquiries) ##
library(caTools)
library(car)
set.seed(111)
model1 = lm(Amount.Requested ~ Monthly.Income, data = dataset)
summary(model1)

model2 = lm(Amount.Requested ~ Monthly.Income + `Loan.Length_36 months`, data = dataset)
summary(model2)
vif(model2)

## model3 <- lm(Amount.Requested ~ Monthly.Income +`Loan.Length_36 months`+`Loan.Length_60 months`,  data = dataset)
## summary(model3)
## vif(model3)   ~ Not getting vif since Loan.Length_36 months`+`Loan.Length_60 months` are highly corelated so i am droping this

model4 <- lm(Amount.Requested ~ Monthly.Income +`Loan.Length_36 months` +Home.Ownership_MORTGAGE, data = dataset)
summary(model4)
vif(model4)

model5 <- lm(Amount.Requested ~ Monthly.Income +`Loan.Length_36 months` +Home.Ownership_MORTGAGE +Inquiries.in.the.Last.6.Months, data = dataset)
summary(model5)
vif(model5)
