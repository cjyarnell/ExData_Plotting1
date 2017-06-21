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

### set plot layout
par(mfrow = c(2,2))

## Plot 1

with(data1, 
     plot(Date_Time, Global_active_power, type = "n", 
          xlab = "", ylab = "Global Active Power"))
lines(data1$Date_Time, data1$Global_active_power)

## Plot 2

with(data1, plot(Date_Time, Voltage, lty = 1, lwd = 1, type = "n"))
with(data1, lines(Date_Time, Voltage))

## Plot 3
with(data1, 
     plot(Date_Time, Sub_metering_1, type = "n", 
          xlab = "", ylab = "Energy sub metering"))
lines(data1$Date_Time, data1$Sub_metering_1)
lines(data1$Date_Time, data1$Sub_metering_2, col = "red")
lines(data1$Date_Time, data1$Sub_metering_3, col = "blue")

legend("topright", names(data)[6:8], 
       col = c("black","red","blue"), lty = 1, bty = "n")

## Plot 4

with(data1, plot(Date_Time, Global_reactive_power, type = "n"))
lines(data1$Date_Time, data1$Global_reactive_power)