##############################################################################################################
## plot2.R Project 1 from "Exploratory Data Analysis" course on Coursera                                    ##
##############################################################################################################
## This code reads electric power consumption data from the UC Irvine Machine Learning Repository web site, ##
## cleans and subsets the data for dates 2007-02-01 and 2007-02-02, then creates a 480 by 480 Plot2.PNG     ##
## file containing a line plot of "Global Active Power" vs. date and time                                   ##
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
png("plot2.png", width = 480, height = 480)

## Generate plot2 ##
with(powerDataSub,
     plot(Global_active_power ~ Datetime,
          type="l",
          xlab="",
          ylab="Global Active Power (kilowatts)"))

dev.off()
