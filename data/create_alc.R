# Author: Martti Kaila
# Date: 09.11.2020
# This script performs the data wrangling part of the Week 3. 

#install.packages("tidyverse")
#install.packages("hrbrthemes")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("viridis")
#install.packages("forcats")
#install.packages("gridExtra") 
#install.packages("GGally")
#install.packages("knitr")

library(GGally)
library(knitr)
library("gridExtra")    
library(tidyverse)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)
library(forcats)

# 3. Read the data
setwd("~/IODS-project/data")

studentPor <- read.csv(file = "student-por.csv", sep = ";")
studentMat <- read.csv(file = "student-mat.csv",  sep = ";")

#Let's summarize the variables and dimension the data. 

dim(studentPor)
dim(studentMat)
# StudenPor data has 649 observations and 33 variables whereas studentMat has 395 observations and 33 
# Let us then summarize the data. 
summary(studentPor)
summary(studentMat)
str(studentPor)
str(studentMat)

# 4. Merge the data together: We just want to keep the obserations that are in both data. 
# Hence, inner_join() command

# vector that defines which variables we use to merge data
joinBy <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

#Merge
mergedData <- inner_join(studentPor, studentMat, by = c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet"))
# Dimensions 
dim(mergedData)
# The merged data has 382 obs. and 53 variables 
# Then summarize the structure of the data and variables of the data 
summary(mergedData)
str(mergedData)

# 5. Clean the duplicate variables. 

# Data containing variables used in merge
data <- select(mergedData, one_of(joinBy))

# Vector not used in merge 
notjoined_columns <- colnames(studentMat)[!colnames(studentMat) %in% joinBy]

# Loop
for(column_name in notjoined_columns) {
  # Variables measuring same thing
  two_columns <- select(mergedData, starts_with(column_name))
  # take the first of these two variables
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # Average
    data[column_name] <- round(rowMeans(two_columns))
  } else { 
    # take the first variable in not numeric 
    data[column_name] <- first_column
  }
}

# 6. Create a variable measuring alcohol consumption 

data <- mutate(data, alc_use = (Dalc + Walc) / 2)
# create the indicator taking value 1 if alcohol consumption > 2 
data <- mutate(data, high_use = alc_use > 2 )

# 7. Check that everything is ok and save the data 

dim(data)
summary(data)

# It seems so. We have 35 variables and 382 observations. Let's save the data 

setwd("~/IODS-project/data")
write.csv(data , file = "joinedData.csv")


