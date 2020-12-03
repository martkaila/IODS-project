# Author: Martti Kaila
# Date: 03.12.2020
# Data wrangling 

# packages 

library(dplyr)
library(tidyr)

# 1 Load the data, check the structure, names and summarize

BPRSData <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATSData <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="", header = T)

# names
names(BPRSData)
names(RATSData)

# have glimpse on the data
glimpse(BPRSData)
glimpse(RATSData)

# summarize 

summary(BPRSData)
summary(RATSData)

#2. Convert the categorical variables of both data sets to factors. 

BPRSData$treatment <- factor(BPRSData$treatment)
BPRSData$subject <- factor(BPRSData$subject)

RATSData$ID <- factor(RATSData$ID)
RATSData$Group <- factor(RATSData$Group)

# 3. Convert the data sets to long form. Add a week variable to BPRSData and a Time variable to RATSData. 

#Change BPRSDataL into Long form and and then get the week varibale 
BPRSData <-  BPRSData %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSData <-  BPRSData %>% mutate(week = as.integer(substr(weeks,5,5)))

# do similar staff with RATSDATA 

RATSData <-  RATSData %>% gather(key = Times, value = Rats, -ID, -Group)
RATSData <-  RATSData %>% mutate(Time = as.integer(substr(Times,3,nchar(Times))))

# 4. Now, take a serious look at the new data sets and compare them with their wide form versions:

# names
names(BPRSData)
names(RATSData)

# have glimpse on the data
glimpse(BPRSData)
glimpse(RATSData)

# summarize 

summary(BPRSData)
summary(RATSData)
setwd("~/IODS-project/data")
write.csv(BPRSData, file = "BPRSData.csv")
write.csv(RATSData, file = "RATSData.csv")
