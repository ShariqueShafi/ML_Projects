library(fastDummies)
library(caTools)
library(car)
set.seed(111)

loan = read.csv("HousingFinance.csv")
View(loan)
summary(loan)
loan = loan[,-1]
summary(loan)

loan = dummy_cols(loan,select_columns = c("Employer_Type","Tier"))
loan$Build_Selfcon = ifelse(loan$Build_Selfcon=="Builder",1,0)
loan$Accommodation_Class = ifelse(loan$Accommodation_Class=="Non_Rented",1,0)
loan$Marital_Status = ifelse(loan$Marital_Status=="Married",1,0)

summary(loan)

### Correlation ###
cr = cor(loan[sapply(loan,is.numeric)])
cr
write.csv(cr,"cor_loan.csv")

## train test split ##
split = sample.split(loan$Decision,SplitRatio = 0.8)
training_data = subset(loan,split == "TRUE")
testing_data = subset(loan,split == "FALSE")
View(training_data)
View(testing_data)

### MODEL ###
model1 = glm(Decision ~ IAR,data = training_data,family=binomial)
summary(model1)  ## Residual deviance: 1194.5, AIC: 1198.5 ##

model2 = glm(Decision ~ IAR+MarVal,data = training_data,family=binomial)
summary(model2) ## Residual deviance: 1179.4, AIC: 1185.4 ##
vif(model2)  ## no correlation

model3 = glm(Decision ~ IAR+MarVal+Term,data = training_data,family=binomial)
summary(model3) ## Residual deviance: 1176.5, AIC: 1184.5 ##
vif(model3)  ## no correlation

model4 = glm(Decision ~ IAR+MarVal+Term+FOIR,data = training_data,family=binomial)
summary(model4) ## Residual deviance: 1128.7, AIC: 1138.7 ##
vif(model4)  ## modrate correlation

model5 = glm(Decision ~ IAR+MarVal+Term+FOIR+IIR,data = training_data,family=binomial)
summary(model5) ## Residual deviance: 1086.9, AIC: 1098.9 ##
vif(model5)  ## IAR   MarVal     Term     FOIR      IIR 
          # 3.881923 1.099954 1.041943 5.277081 6.503907 

model6 = glm(Decision ~ IAR+MarVal+Term+FOIR+OldEmi,data = training_data,family=binomial)
summary(model6) ## Residual deviance: 1104.6, AIC: 1116.6 ##
vif(model6)  #### modrate correlation

model7 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV,data = training_data,family=binomial)
summary(model7) ## Residual deviance: 1084.5, AIC: 1096.5 ##
vif(model7)  #### modrate correlation

model8 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd,data = training_data,family=binomial)
summary(model8) ## Residual deviance: 1082.4, AIC: 1096.4 ##
vif(model8)  #### modrate correlation

model9 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc,data = training_data,family=binomial)
summary(model9) ## Residual deviance: 1081.6, AIC: 1097.6 ##
vif(model9)  #### modrate correlation

model10 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob,data = training_data,family=binomial)
summary(model10) ## Residual deviance: 1078.8, AIC: 1096.8 ##
vif(model10)  #### modrate correlation

model11 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+CalcEmi,data = training_data,family=binomial)
summary(model11) ## Residual deviance: 1077.5, AIC: 1097.5 ##
vif(model11)  #### modrate correlation

model12 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Age,data = training_data,family=binomial)
summary(model12) ## Residual deviance: 1078.4, AIC: 1098.4 ##
vif(model12)  #### modrate correlation

model13 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+LoanReq,data = training_data,family=binomial)
summary(model13) ## Residual deviance: 1077.4, AIC: 1097.4 ##
vif(model13)  ####  IAR   MarVal     Term     FOIR      LTV   YrsAdd   TotInc   YrsJob  LoanReq 
              # 2.944150 3.796767 1.466922 2.831063 2.664446 1.110306 2.648439 1.068851 4.290407 

model14 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2,data = training_data,family=binomial)
summary(model14) ## Residual deviance: 1065.1, AIC: 1085.1 ##
vif(model14) #### modrate correlation

colnames(training_data)[25] <- "Employer_Type_Ind_SmallBus"
colnames(testing_data)[25] <- "Employer_Type_Ind_SmallBus"


model15 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+Employer_Type_Ind_SmallBus,data = training_data,family=binomial)
summary(model15) ## Residual deviance: 1063.3, AIC: 1085.3 ##
vif(model15) #### modrate correlation

model16 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d,data = training_data,family=binomial)
summary(model16) ## Residual deviance: 1043.6, AIC: 1065.6 ##
vif(model16) #### modrate correlation

model17 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d,data = training_data,family=binomial)
summary(model17) ## Residual deviance: 1007.5, AIC: 1031.5 ##
vif(model17) #### IAR     MarVal       Term       FOIR        LTV     YrsAdd     TotInc     YrsJob     Tier_2    BankSave_d   OldEmi_d 
            ## 3.701032   2.344866   1.302588   4.012666   1.894695   1.116851   2.273076   1.101772   1.032997   1.045017    1.394694 

model18 = glm(Decision ~ IAR+MarVal+Term+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d,data = training_data,family=binomial)
summary(model18) ## Residual deviance: 1060.4, AIC: 1082.4 ##
vif(model18)  ## no correlation

model19 = glm(Decision ~ MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d,data = training_data,family=binomial)
summary(model19) ## Residual deviance: 1102.4, AIC: 1124.4 ##
vif(model19) #### modrate correlation

model20 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Corporate,data = training_data,family=binomial)
summary(model20) ## Residual deviance: 1006.1, AIC: 1032.1 ##
vif(model20)  #### more than modrate correlation

model21 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Marital_Status,data = training_data,family=binomial)
summary(model21) ## Residual deviance: 1007.2, AIC: 1033.2 ##
vif(model21)  #### more than modrate correlation

model22 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Govt,data = training_data,family=binomial)
summary(model22) ## Residual deviance: 1005.1, AIC: 1031.1 ##
vif(model22)  #### more than modrate correlation

model23 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Govt+Build_Selfcon,data = training_data,family=binomial)
summary(model23) ## Residual deviance: 1005.0, AIC: 1033 ##
vif(model23)  #### more than modrate correlation

model24 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Govt+Tier_3,data = training_data,family=binomial)
summary(model24) ## Residual deviance: 1004.7, AIC: 1032.7 ##
vif(model24) #### more than modrate correlation

model25 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Govt+Accommodation_Class,data = training_data,family=binomial)
summary(model25) ## Residual deviance: 1004.4, AIC: 1032.4 ##
vif(model25) #### more than modrate correlation

model26 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Govt+Employer_Type_Business,data = training_data,family=binomial)
summary(model26) ## Residual deviance: 997.67, AIC: 1025.7 ##
vif(model26) #### more than modrate correlation

###    IAR          MarVal          Term        FOIR        LTV         YrsAdd         TotInc          YrsJob        Tier_2          BankSave_d        OldEmi_d     Employer_Type_Govt   Employer_Type_Business  
##  3.762913       2.320422      1.315722    4.225549     1.890085     1.11973        2.254816        1.356108      1.038444          1.048909         1.417689          1.312345              1.514230 

model27 = glm(Decision ~ IAR+MarVal+Term+FOIR+LTV+YrsAdd+TotInc+YrsJob+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Govt+Employer_Type_Business+Tier_1,data = training_data,family=binomial)
summary(model27) ## Residual deviance: 997.38, AIC: 1027.4 ##
vif(model27) #### more than modrate correlation

## Model with maximum significant is model26 ##

### Prediction
res = predict(model26,testing_data,type="response")
head(res)
head(testing_data$Decision)

library(caret)
pred_class = ifelse (res >0.75,1,0)

confusionMatrix(as.factor(pred_class),as.factor(testing_data$Decision),positive = "1")
## Accuracy : 0.7739, Sensitivity : 0.8048 ##
              ##              Reference
              ## Prediction    0      1
              ##         0    41     49
              ##         1    22     202

model28 = glm(Decision ~ IAR+Term+FOIR+LTV+YrsAdd+TotInc+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Business,data = training_data,family=binomial)
summary(model28) ## Residual deviance: 1001.0, AIC: 1023 ##
vif(model28) #### more than modrate correlation

model29 = glm(Decision ~ IAR+Term+FOIR+LTV+YrsAdd+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Business,data = training_data,family=binomial)
summary(model29) ## Residual deviance: 1001.2, AIC: 1021.2 ##
vif(model29) #### more than modrate correlation

model30 = glm(Decision ~ IAR+Term+FOIR+LTV+Tier_2+BankSave_d+OldEmi_d+Employer_Type_Business,data = training_data,family=binomial)
summary(model30) ## Residual deviance: 1003.0, AIC: 1021 ##
vif(model30) #### more than modrate correlation

res = predict(model30,testing_data,type="response")
head(res)
head(testing_data$Decision)

library(caret)
pred_class = ifelse (res >0.75,1,0)

confusionMatrix(as.factor(pred_class),as.factor(testing_data$Decision),positive = "1")
## Accuracy : 0.7611, Sensitivity : 0.7928 ##
                 ##              Reference
                 ## Prediction    0      1
                 ##         0    40     52
                 ##         1    23     199

