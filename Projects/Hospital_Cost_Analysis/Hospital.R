library(corrplot)
hospital_pre = read.csv("IMB529-XLS-PRE.csv")
summary(hospital_pre)
View(hospital_pre)

hospital_pre$PAST.MEDICAL.HISTORY.CODE = as.factor(hospital_pre$PAST.MEDICAL.HISTORY.CODE)
hospital_pre$KEY.COMPLAINTS..CODE = as.factor(hospital_pre$KEY.COMPLAINTS..CODE)

hospital_pre$GENDER = ifelse (hospital_pre$GENDER=="M",1,0)
hospital_pre$STATE.AT.THE.TIME.OF.ARRIVAL = ifelse (hospital_pre$STATE.AT.THE.TIME.OF.ARRIVAL=="ALERT",1,0)
hospital_pre$TYPE.OF.ADMSN = ifelse (hospital_pre$TYPE.OF.ADMSN=="EMERGENCY",1,0)
hospital_pre$MODE.OF.ARRIVAL = ifelse (hospital_pre$MODE.OF.ARRIVAL=="AMBULANCE",1,0)
hospital_pre$MARITAL.STATUS = ifelse (hospital_pre$MARITAL.STATUS=="MARRIED",1,0)
hospital_pre$IMPLANT.USED..Y.N. = ifelse (hospital_pre$IMPLANT.USED..Y.N.=="Y",1,0)

library(fastDummies)
hospital_pre = dummy_cols(hospital_pre, select_columns = c ("KEY.COMPLAINTS..CODE", "PAST.MEDICAL.HISTORY.CODE"))

library(corrplot)
cr1 <- cor(hospital_pre[sapply(hospital_pre,is.numeric)])
cr1
corrplot.mixed(cr1)
corrplot(cr1,type = "full")
corrplot(cr1,method = "number")
write.csv(cr1,"corML.csv")

## Highest Cor = AGE, TOTAL.LENGTH.OF.STAY, LENGTH.OF.STAY...ICU, IMPLANT.USED..Y.N., 
              ## COST.OF.IMPLANT, BODY.WEIGHT, BODY.HEIGHT, CREATININE, MODE.OF.ARRIVAL, TYPE.OF.ADMSN

hospital = read.csv("IMB529-XLS-ENG.xlsx - MH-Raw Data.csv")
summary(hospital)
View(hospital)
hospital$PAST.MEDICAL.HISTORY.CODE = as.factor(hospital$PAST.MEDICAL.HISTORY.CODE)
hospital$KEY.COMPLAINTS..CODE = as.factor(hospital$KEY.COMPLAINTS..CODE)

hospital$GENDER = ifelse (hospital$GENDER=="M",1,0)
hospital$STATE.AT.THE.TIME.OF.ARRIVAL = ifelse (hospital$STATE.AT.THE.TIME.OF.ARRIVAL=="ALERT",1,0)
hospital$TYPE.OF.ADMSN = ifelse (hospital$TYPE.OF.ADMSN=="EMERGENCY",1,0)
hospital$MODE.OF.ARRIVAL = ifelse (hospital$MODE.OF.ARRIVAL=="AMBULANCE",1,0)
hospital$MARITAL.STATUS = ifelse (hospital$MARITAL.STATUS=="MARRIED",1,0)
hospital$IMPLANT.USED..Y.N. = ifelse (hospital$IMPLANT.USED..Y.N.=="Y",1,0)

library(fastDummies)
hospital = dummy_cols(hospital, select_columns = c ("KEY.COMPLAINTS..CODE", "PAST.MEDICAL.HISTORY.CODE"))
##

library(caTools)
set.seed(111)
split = sample.split(hospital$TOTAL.COST.TO.HOSPITAL, SplitRatio = 0.85)
training_data = subset(hospital,split == "TRUE")
testing_data = subset(hospital,split == "FALSE")
View(training_data)
View(testing_data)

library(psych)
library(car)
library(skedastic)
library(lmtest)
pairs.panels(training_data[c("AGE", "TOTAL.LENGTH.OF.STAY", "LENGTH.OF.STAY...ICU", "IMPLANT.USED..Y.N.", "COST.OF.IMPLANT", "BODY.WEIGHT", "BODY.HEIGHT", "MODE.OF.ARRIVAL", "TYPE.OF.ADMSN")])

model1 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE, data = training_data)
summary(model1)
plot(model1$fitted.values,model1$residuals)
lmtest::bptest(model1)
skedastic::white(model1)

model2 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+TOTAL.LENGTH.OF.STAY, data = training_data)
summary(model2)
vif(model2)
plot(model2$fitted.values,model2$residuals)
lmtest::bptest(model2)
skedastic::white(model2)

model3 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+TOTAL.LENGTH.OF.STAY+LENGTH.OF.STAY...ICU, data = training_data)
summary(model3)
vif(model3)
plot(model3$fitted.values,model2$residuals)
lmtest::bptest(model3)
skedastic::white(model3)

model4 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+LENGTH.OF.STAY...ICU+IMPLANT.USED..Y.N.+COST.OF.IMPLANT, data = training_data)
summary(model4)
vif(model4)
plot(model4$fitted.values,model4$residuals)
lmtest::bptest(model4)
skedastic::white(model4)

model5 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+LENGTH.OF.STAY...ICU+COST.OF.IMPLANT+BODY.WEIGHT, data = training_data)
summary(model5)
vif(model5)
plot(model5$fitted.values,model4$residuals)
lmtest::bptest(model5)
skedastic::white(model5)

model6 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+LENGTH.OF.STAY...ICU+COST.OF.IMPLANT+BODY.WEIGHT+BODY.HEIGHT, data = training_data)
summary(model6)
vif(model6)
plot(model6$fitted.values,model6$residuals)
lmtest::bptest(model6)
skedastic::white(model6)

model7 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+LENGTH.OF.STAY...ICU+COST.OF.IMPLANT+BODY.WEIGHT+BODY.HEIGHT+MODE.OF.ARRIVAL, data = training_data)
summary(model7)
vif(model7)
plot(model7$fitted.values,model7$residuals)
lmtest::bptest(model7)
skedastic::white(model7)

model8 = lm(TOTAL.COST.TO.HOSPITAL ~ AGE+LENGTH.OF.STAY...ICU+COST.OF.IMPLANT+BODY.WEIGHT+BODY.HEIGHT+MODE.OF.ARRIVAL+TYPE.OF.ADMSN, data = training_data)
summary(model8)
vif(model8)
plot(model8$fitted.values,model8$residuals)
lmtest::bptest(model8)
skedastic::white(model8)

prediction1 = predict(model1,testing_data)
prediction2 = predict(model2,testing_data)
prediction3 = predict(model3,testing_data)
prediction4 = predict(model4,testing_data)
prediction5 = predict(model5,testing_data)
prediction6 = predict(model6,testing_data)
prediction7 = predict(model7,testing_data)
prediction8 = predict(model8,testing_data)
head(c(prediction1,prediction2,prediction3,prediction4,prediction5,prediction6,prediction7,prediction8,hospital$TOTAL.COST.TO.HOSPITAL))

plot(testing_data$TOTAL.COST.TO.HOSPITAL,type="l",col="red")
lines(prediction1,type = "l", col="grey")
lines(prediction2,type = "l", col="lightblue")
lines(prediction3,type = "l", col="lightgreen")
lines(prediction4,type = "l", col="thistle")
lines(prediction5,type = "l", col="lightpink")
lines(prediction6,type = "l", col="khaki")
lines(prediction7,type = "l", col="peachpuff")
lines(prediction8,type = "l", col="paleturquoise")

results <- data.frame(
  Observation = 1:length(testing_data$TOTAL.COST.TO.HOSPITAL),
  Actual = testing_data$TOTAL.COST.TO.HOSPITAL,
  Model1 = prediction1,
  Model2 = prediction2,
  Model3 = prediction3,
  Model4 = prediction4,
  Model5 = prediction5,
  Model6 = prediction6,
  Model7 = prediction7,
  Model8 = prediction8)
View(results)

write.csv(results,"results.csv")