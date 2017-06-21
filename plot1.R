# Week 1 Project #

# Code to download the source file #
setwd("/Users/cyarnell/Documents/Active Projects/MAGIC: LAMP/Data Science Stream/Exploratory Data Analysis")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "UCI Electric Power Consumption Dataset.zip")
unzip("UCI Electric Power Consumption Dataset.zip", exdir = "UCI Electric Power Consumption Dataset")
setwd("UCI Electric Power Consumption Dataset")

# load in data
library(data.table)
library(lubridate)
library(dplyr)

# read in data
data <- read.table(dir()[1], header = TRUE, sep = ";", 
                   na.strings = "?", 
                   colClasses = c("character", "character", 
                                  "numeric", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric", 
                                  "numeric"))

data <- unite(data, Date_Time, Date, Time, sep = " ", remove = TRUE)
data$Date_Time <- dmy_hms(data$Date_Time)

# select only relevant days
start = ymd_hms("2007-02-01 00:00:00")
end = ymd_hms("2007-02-03 00:00:00")
data1 <- filter(data, Date_Time >= start & Date_Time < end)

hist(data1$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     border = "black", col = "red")



