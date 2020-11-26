# Author: Martti Kaila
# Date: 09.11.2020
# This script performs the data wrangling part of the Week €

library(dplyr) 
library("tidyverse")

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
colnames(hd) <- c("hdiRank","country","hdi","lifeExp","eduExp","eduMean","gni","gniMinusRank")
colnames(gii) <- c("giiRank","country","gii","matMor","adoBirth","Parli.F","edu2Fat","edu2Mot","laborFat","laborMot")

# 5.  Create asked ratios.  
gii$edu2FM<- gii$edu2Fat / gii$edu2Mot
gii$laborFM <- gii$laborFat/ gii$laborMot

# 6. Merge data and save it 
human <- inner_join(hd, gii, by = "country")

setwd("~/IODS-project/data")
write.csv(human, file = "human.csv")

###########################
#                        #
#      WEEK 5            #
#                        #
##########################

# 0.) Load the data and summarize. 
# 
human <- read.csv(file = "human.csv")
human <- select(human,-X)

glimpse(human) 
summary(human)

# So we have around 195 observations and 19 variables. The data has been created by merging together Human Development
# index data that contains several variables measuring countries' level of development, and 
# data on gender norms that measures , for example, how large fraction of women/men have certain education
# level or are working. 

# 1) 
human$gni <- as.numeric(gsub(",", "", human$gni))

# 2) Select the variables we need
human <- select(human, country, edu2FM, laborFM, eduExp, lifeExp, gni, matMor, adoBirth, Parli.F )

# 3) Get rid of observations with missing values. 
human <- human %>% drop_na()

# 4) Remove the observations which relate to regions instead of countries

human <- human[-c(154,156:162), ]

# 5) Rename the rows ,delete the country variable, and save 

rownames(human) <- human$country
human <- select(human,-country)

write.csv(human, file = "human.csv")

