#CLEANING THE DATA
#--------------------------------------------------------------------------------
library(readr)
Kenya_Deliveries <- read_csv("Kenya Deliveries.csv", 
                             col_types = cols(Notes = col_skip(), 
                                              `Total_Time_Taken(min)` = col_double(), 
                                              Special_Instructions = col_skip()))
#View(Kenya_Deliveries)

#--------------------------------------------------------------------
#Deliveries Kenya
Kenya_Deliveries=Kenya_Deliveries[order(Kenya_Deliveries$Pick_up_From),]
kenia_del_1=Kenya_Deliveries[110:44983,1:32]
kenia_del_3=Kenya_Deliveries[1:109,1:34]
kenia_del_3=kenia_del_3[,-c(6,24)]
kenia_del_1_colnames <- colnames(kenia_del_1)
colnames(kenia_del_3)=kenia_del_1_colnames

#Asignamos NA  las columnas Task_Details_QTY y Task_Details_AMOUNT 
# de las filas 1:109
kenia_del_3$Task_Details_QTY="NA"
kenia_del_3$Task_Details_AMOUNT="NA"

#Unimos las base de datos 
Kenya_Deliveries1=rbind(kenia_del_3,kenia_del_1)

#Asignamos una columna country para indicar lo que corresponde a Kenya
Kenya_Deliveries1$Country="Kenya"


#--------------------------------------------------------------------
#Deliveries Nigeria
library(readr)
Nigeria_Deliveries <- read_csv("Nigeria Deliveries.csv", 
                               col_types = cols(Notes = col_skip(), 
                                                `Total_Time_Taken(min)` = col_double(), 
                                                Special_Instructions = col_skip()))
#View(Nigeria_Deliveries)


Nigeria_Deliveries$Agent_Name="NA"
Nigeria_Deliveries$Country="Nigeria"
Nigeria_Deliveries1=Nigeria_Deliveries

#Eliminamos los currency symbols
Nigeria_Deliveries1$Task_Details_AMOUNT = as.numeric(gsub("\\₦ ", "", Nigeria_Deliveries1$Task_Details_AMOUNT))
Nigeria_Deliveries1$Tip = as.numeric(gsub("\\₦ ", "", Nigeria_Deliveries1$Tip))
Nigeria_Deliveries1$Delivery_Charges = as.numeric(gsub("\\₦ ", "", Nigeria_Deliveries1$Delivery_Charges))
Nigeria_Deliveries1$Discount = as.numeric(gsub("\\₦ ", "", Nigeria_Deliveries1$Discount))

Kenya_Deliveries1$Task_Details_AMOUNT = as.numeric(gsub("\\KSh ", "", Kenya_Deliveries1$Task_Details_AMOUNT))
Kenya_Deliveries1$Tip = as.numeric(gsub("\\KSh ", "", Kenya_Deliveries1$Tip))
Kenya_Deliveries1$Delivery_Charges = as.numeric(gsub("\\KSh ", "", Kenya_Deliveries1$Delivery_Charges))
Kenya_Deliveries1$Discount = as.numeric(gsub("\\KSh ", "", Kenya_Deliveries1$Discount))



#Unimos ambas bases de datos
Deliveries=rbind(Kenya_Deliveries1,Nigeria_Deliveries1)
Deliveries1=Deliveries

#Guardamos la base de datos Deliveries
write.csv(Deliveries, file = "Deliveries.csv", row.names = FALSE) 


#--------------------------------------------------------------
#----------------------------ORDERS-------------------
# Kenia
library(readr)
Kenya_Orders <- read_csv("Kenya Orders.csv")
#View(Kenya_Orders)

Kenya_Orders$Country="Kenya"



library(readr)
Nigeria_Orders <- read_csv("Nigeria Orders.csv")
View(Nigeria_Orders)

library(reshape)
Nigeria_Orders$Debt_Amount="NA"
Nigeria_Orders = rename(Nigeria_Orders, c(Debt_Amount="Debt Amount"))
Nigeria_Orders$Country="Nigeria"



#Unimos ambas bases de datos
Orders=rbind(Kenya_Orders,Nigeria_Orders)

#Guardamos la base de datos Orders
write.csv(Orders, file = "Orders.csv", row.names = FALSE) # guarda un archivo csv

#--------------------------------------------------------------
#----------------------------CUSTOMERS-------------------
# Kenia
library(readr)
Kenya_Customers <- read_csv("Kenya Customers.csv", 
                            col_types = cols(`Upload restuarant location` = col_skip()))
#View(Kenya_Customers)

Kenya_Customers$Country="Kenya"

library(readr)
Nigeria_Customers <- read_csv("Nigeria Customers.csv")
#View(Nigeria_Customers)

Kenya_Customers = rename(Kenya_Customers, c("Number of employees"="Number of Employees"))

Nigeria_Customers$Country="Nigeria"

#Unimos ambas bases de datos
Customers=rbind(Kenya_Customers,Nigeria_Customers)
Customers$`Number of Employees`=as.integer(Customers$`Number of Employees`)

write.csv(Customers, file = "Customers.csv", row.names = FALSE) # guarda un archivo csv
