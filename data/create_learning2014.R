# Author: Martti Kaila
# Date: 03.11.2020

#install.packages("tidyverse")
#install.packages("hrbrthemes")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("viridis")
#install.packages("forcats")
#install.packages("gridExtra") 


library("gridExtra")    
library(tidyverse)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)
library(forcats)

# 2.  
#Read the data into R
data <- read.delim('https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt')

#Data contain 183 observations and 60 variables 

# 3. Create the data for data analysis 
# Generate STRA 
data$Stra <- (data$ST01+data$ST09+data$ST17+data$ST25+data$ST04+data$ST12+data$ST20+data$ST28)/8
# Generate Depp
data$Deep <- (data$D03 + data$D11 + data$D19 + data$D27 +
  data$D07 + data$D14 + data$D22 + data$D30+data$D06 + data$D15 + data$D23 + data$D31)/12
# Generate Surf 
data$Surf <- (data$SU02+data$SU10+data$SU18+data$SU26 + data$SU05+data$SU13+data$SU21+
  data$SU29+ data$SU08+data$SU16+data$SU24+data$SU32)/12
# Scale attitude 
data$Attitude <- data$Attitude/10 

data$gender <- ifelse(data$gender == "M", 0, ifelse(data$gender == "F", 1, 2))

# Pick the variables we want to use and get rid of the observations in which points == 0
analysisData <- data %>%
  filter(Points > 0) %>%
  select(Attitude, gender, Age, Stra, Deep, Points, Surf)
#Lets save the data 
setwd("~/IODS-project/data")
write.csv(analysisData , file = "learning2014.csv")
#Lets read the data back in R 
learning2014 <- read.csv(file = "learning2014.csv")

str(learning2014)
head(learning2014)
