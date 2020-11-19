# Author: Martti Kaila
# Date: 09.11.2020
# This script performs the data wrangling part of the Week €

library(dplyr) 

# 1. Create scrip: Done! 

# 2. Get the data 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3.  Dimensions, structures and summaries
glimpse(hd) 
glimpse(gii) 
summary(hd)
summary(gii)

# 4. Rename the variables
colnames(hd) <- c("hdiRank","country","hdi","lifeExp","eduExp","eduMean","Ggni","gniMinusRank")
colnames(gii) <- c("giiRank","country","gii","matMor","adoBirth","Parli.F","edu2Fat","edu2Mot","laborFat","laborMot")

# 5.  Create asked ratios.  
gii$edu2FM<- gii$edu2Fat / gii$edu2Mot
gii$laborFM <- gii$laborFat/ gii$laborMot

# 6. Merge data and save it 
human <- inner_join(hd, gii, by = "country")

setwd("~/IODS-project/data")
write.csv(human, file = "human.csv")
