Marketing= read.csv("Marketing.csv")
summary(Marketing)
View(Marketing)
library(fastDummies)
Marketing = dummy_cols(Marketing, select_columns = c ("History","Age"))
Marketing$Gender= ifelse (Marketing$Gender=="Male",1,0)
Marketing$OwnHome= ifelse (Marketing$OwnHome=="Own",1,0)
Marketing$Location= ifelse (Marketing$Location=="Far",1,0)
crm = cor(Marketing[c("History_High","History_Medium","History_Low","Age_Old","Age_Young",
                     "Age_Middle","Gender","OwnHome","Location","Salary","Children","Catalogs","AmountSpent")])
crm
corrplot.mixed(crm)
corrplot(crm,type = "full")
corrplot(crm,method = "number")
