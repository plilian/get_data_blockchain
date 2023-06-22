library(prophet)
library(tidyverse)
solusdt <- read.csv("filepath_to_original_file//solusdt.csv")
modelA <- prophet(solusdt)
futureA <- make_future_dataframe(modelA, periods = 10) #period in Days
tail(futureA) 
forecastsol <- predict(modelA, futureA)
tail(forecastsol[c('ds','yhat','yhat_lower','yhat_upper')])
write.csv(forecastsol,file="file_path_to_save_file//output.csv",fileEncoding = "UTF-8")
