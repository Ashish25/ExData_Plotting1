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


# Making a POSIXct date capable of being filtered and graphed by time of day
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subsetting Dates for 2007-02-01 and 2007-02-02
data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# rearranging the dateTime columns
data <- data[, c(1,2,10,3,4,5,6,7,8,9)]

# in total we need 4 graphs on our canvas
par(mfrow=c(2,2))

# Plot 1
with(data, plot(dateTime~Global_active_power, type="l",
           ylab="Global Active Power (kilowatts)", xlab="", cex = 0.2))

# Plot 2
with(data, plot(dateTime~Voltage,  type="l",
           xlab="", ylab="Global Active Power", cex = 0.2))

# Plot 3
plot(data$dateTime , data$Sub_metering_1, xlab="", ylab="Energy sub metering", cex = 0.2)
lines(data$dateTime, data$Sub_metering_1, type= "l",col="black")
lines(data$dateTime, data$Sub_metering_2, type= "l",col="red")
lines(data$dateTime, data$Sub_metering_3,type= "l",col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), 
       lty=c(1,1), bty="n", cex=.5) 

# Plot 4
plot(data$dateTime, data$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

# saving as png file with dimensions using graphicaDevices functions
dev.cur()
dev.copy(png(filename =  "plot3.png", width=480, height=480))
dev.off()  #ShutDown the envoked Graphicdevices
