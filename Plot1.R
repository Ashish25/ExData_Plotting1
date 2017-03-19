#Setting my directory
setwd("K:/DataScience/Coursera-JHU- DataScience-RogerPeng/4. Exploratory Data Analysis/02 - Week 1")

# Calling libraries
library(dplyr)
library(lubridate)
library(data.table)

#Reading the dataset
full_data <- data.table::fread(input = "household_power_consumption.txt",
                             header=T, sep=';', na.strings="?",
                             nrows = 2075259,
                             stringsAsFactors = FALSE, check.names=F)

# subsetting the data
data <- subset(full_data, Date %in% c("1/2/2007","2/2/2007"))

# converting Date and Time column to Date/Time format from character
DT <- paste(as.Date(data$Date), data$Time)
data$dataTime <- as.POSIXct(DT)

# rearrange the columns
data <- data[, c(1,2,10,3,4,5,6,7,8,9)]

# # handling Scientific Notation that might result at plotting
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# histrogram for plot1
hist(data$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", col="Red",
     main="Global Active Power")


# saving as png file with dimensions using graphicaDevices functions
dev.cur()
dev.copy(png(filename =  "plot1.png", width=480, height=480))
dev.off()  #ShutDown the envoked devices
