##############################################################################################################
## plot4.R Project 1 from "Exploratory Data Analysis" course on Coursera                                            ##
##############################################################################################################
## This code reads electric power consumption data from the UC Irvine Machine Learning Repository web site, ##
## cleans and subsets the data for dates 2007-02-01 and 2007-02-02, then creates 480 by 480 Plot4.PNG file. ##
## The plot is a matrix of four plots: line plot of Global Active Power vs. Date & Time, line plot of       ##
## Voltage vs. Date & Time, line plot of Energy Sub Metering broken out by the three Sub Metering groupings ##
## vs. Date & Time and Global Reactive Power vs. Date & Time arranged in a 2 x 2 matrix                     ##
##############################################################################################################

## Load necessary libraries ##
library(downloader)

## set working directory. ##
setwd("~/R/Exploratory Data Analyis/")

## Download data from the UC Irvine Machine Learning Repository and extract the data ##
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(data_url, dest="dataset.zip", mode="wb") 
## Extract household_power_consumption.txt from ZIP file ##
unzip ("dataset.zip")

## Read data file extracted from ZIP into table ##
powerData <- read.table("household_power_consumption.txt", 
                        header = TRUE, 
                        sep = ";",
                        na.strings = "?",
                        colClasses = c("character",
                                       "character",
                                       rep("numeric",7)))

## Convert date and time from character classes ##
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")

## Subset the data to reduce table size ##
powerDataSub <- subset(powerData, (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(powerData)

## Compute Date-Time from Date and Time columns ##
dateTime <- paste(as.Date(powerDataSub$Date), powerDataSub$Time)
powerDataSub$Datetime <- as.POSIXct(dateTime)

## Output plot to 480 by 480 PNG file ##
png("plot4.png", width = 480, height = 480)

## Set environment for 2 by 2 plot layout ##
par(mfrow = c(2,2),
    mar = c(5,4,2,1),
    oma = c(0,0,0,0))

## Global Active Power vs. Datetime ##
with(powerDataSub, {
     plot(Global_active_power ~ Datetime,
          type = "l",
          col = "black",
          xlab = "",
          ylab = "Global Active Power")
})

## Voltage vs. Datetime ##
with(powerDataSub, {
      plot(Voltage ~ Datetime,
           type = "l",
           col = "black",
           xlab = "datetime",
           ylab = "Voltage")
})

## Sub metering vs. Datetime ##
with(powerDataSub, {
      plot(Sub_metering_1 ~ Datetime,
           type = "l",
           col = "black",
           xlab = "",
           ylab = "Energy sub metering")
      lines(Sub_metering_2 ~ Datetime,
            type="l",
            col = "red")
      lines(Sub_metering_3 ~ Datetime,
            type = "l",
            col = "blue")
})
legend("topright",
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Global Active Power vs. Datetime ##
with(powerDataSub, {
      plot(Global_reactive_power ~ Datetime,
           col = "black",
           type = "l",
           xlab = "datetime",
           ylab = "Global_reactive_power")
})

dev.off()
