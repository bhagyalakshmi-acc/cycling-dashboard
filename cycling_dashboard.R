install.packages(c("httr","jsonlite"))
library(httr)
library(jsonlite)
library(lubridate)
library(tidyverse) /
#api requests
access_token = POST("https://www.strava.com/oauth/token?client_id= &client_secret= &refresh_token= &grant_type=refresh_token")
at = fromJSON(rawToChar(access_token$content))
acc_token <- at$access_token 
res = GET(sprintf("https://www.strava.com/api/v3/athlete/activities?access_token=%s" ,acc_token)) /
#covert to json Unicode
rawToChar(res$content) /
#create list 
data = fromJSON(rawToChar(res$content))
data /
#creating a dataset with the variables needed
my_dataset <- data.frame(date=data$start_date_local,distance=data$distance,time=data$moving_time) /
#converting distance to kms
my_dataset$distance <- round((my_dataset$distance / 1000 ),digits=2) /
#format date
my_dataset$date <- substr(my_dataset$date, 1, 10) /
#getting sys date and converting to character
sys_date <- as.character(Sys.Date()) /
#get the current_months data from my_dataset and store in current_month
current_month <- data.frame(my_dataset %>% filter(substr(sys_date,6,7)==substr(my_dataset$date,6,7)) %>% select(date,distance,time)) /
#create a vector with all dates of current month
cur_month_sdate <- floor_date(Sys.Date(), unit = "month")
cur_month_edate <- ceiling_date(Sys.Date(), unit = "month")-1
month_vector <- seq(cur_month_sdate, cur_month_edate, by = "1 days") /
#create month_vector dataframe
month_vector <- data.frame(month_vector)
colnames(month_vector) <- "date"
month_vector$date <- as.character(month_vector$date) /
#assign values in month_vector for all TRUE values in current_month
month_vector <- merge(month_vector,current_month,all = TRUE) /
#plot current month graph
month_vector %>% ggplot(aes(x=date,y=distance)) + geom_bar(stat = "identity",position = "stack" , fill = "#228B22", width = 0.5) + theme(axis.text.x = element_text(angle = 90)) /
#create a datframe with month and average distance for plotting last six month average distance
month_avg <- my_dataset %>% select(date,distance) %>% group_by(month =month.abb[as.numeric(substr(my_dataset$date,6,7))]) %>% summarise(distance=mean(distance)) /
#plot last six months avg distance graph
month_avg %>% ggplot(aes(x=month,y=distance)) + geom_bar(stat = "identity",position = "stack") + theme(axis.text.x = element_text(angle = 90)) /






