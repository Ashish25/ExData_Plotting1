#Setting my directory
setwd("K:/DataScience/Coursera-JHU- DataScience-RogerPeng/4. Exploratory Data Analysis/02 - Week 1")


# Calling libraries
library(dplyr)
library(lubridate)
library(data.table)

#Reading the dataset
data <- data.table::fread(input = "household_power_consumption.txt",
                               header=T, sep=';', na.strings="?",
                               nrows = 2075259,
                               stringsAsFactors = FALSE, check.names=F)

# handling Scientific Notation that might result at plotting
data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subsetting Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# rearranging the dateTime columns
data <- data[, c(1,2,10,3,4,5,6,7,8,9)]

## Plot 2
plot(x = data$dateTime,
     y = data$Global_active_power,
     type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

# saving as png file with dimensions using graphicaDevices functions
dev.cur()
dev.copy(png(filename =  "plot2.png", width=480, height=480))
dev.off()  #ShutDown the envoked Graphicdevices