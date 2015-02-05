## This script reads in the UCI Machine Learning repositiory individual
## household electric power consumption dataset described in the EDA
## course project 1 and outputs the required plot4.png chart

## Step 1: Set everything up.
## --------------------------

## Set the working directury (this may require modification depending on the 
## local directory structure used)
setwd(
  "~/Documents/Data Science Specialisation/4 - Exploratory Analysis/Project 1")

## Set the path for the  data file. This assumes the UCI data set has been 
## downloaded & unzipped in the project 1 directory and not modified. If not, 
## then this should be done and the path modified, if needed.
dataSetPath         <- "./household_power_consumption.txt"

## Step 2: Read in the data set.
## --------------------------------------------------------------------

## Load the data file
vars                <- c("character", "character", rep("numeric", 7))
dataSet             <- read.table(dataSetPath, h=1, sep=";", colClasses=vars, 
                                                                na.strings="?")

## Step 3: Subset the data set, clear memory and create POSIX date/time
## ---------------------------------------------------------------------

## Subset according to dates required and clean up memory
dataSubSet      <- dataSet[dataSet$Date=="1/2/2007"|dataSet$Date=="2/2/2007",]
rm(dataSet)
gc()

## Create a new vector of Posix objects containing date & time
dateTime            <- as.POSIXlt(paste(as.Date(dataSubSet$Date, 
                                format="%d/%m/%Y"), dataSubSet$Time, sep=" "))

## Step 4: Draw the chart 
## ---------------------------------------------------------------------

## Send a copy to the plot4.png output file
png("plot4.png", width=480, height=480)

## Set the margins and layout - for transparent background fill just add ,bg=NA.
par(mar=c(5.0, 4.7, 3.5, 0.7), mfrow=c(2,2))

## Draw 1st chart  (top left)
plot(dateTime, dataSubSet$Global_active_power, type="l", xlab="", 
                          ylab="Global Active Power", cex.lab=1.0, cex.axis=1.0)

## Draw 2nd chart (top right)
plot(dateTime, dataSubSet$Voltage, type="l", xlab="datetime", ylab="Voltage", 
                                                      cex.lab=1.0, cex.axis=1.0)

## Draw 3rd chart (bottom left)
plot(dateTime, dataSubSet$Sub_metering_1, type="n", lwd=1, xlab="", 
                          ylab="Energy sub metering", cex.lab=1.0, cex.axis=1.0)

lines(dateTime, dataSubSet$Sub_metering_1, col="black")
lines(dateTime, dataSubSet$Sub_metering_2, col="red")
lines(dateTime, dataSubSet$Sub_metering_3, col="blue")

legend("topright", lwd=1, col=c("black", "red", "blue"), 
              legend=c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "),
                                              box.lwd=0, cex=1.0, y.intersp=0.9)

## Draw 4th chart (bottom right)
plot(dateTime, dataSubSet$Global_reactive_power, type="l", xlab="datetime", 
                        ylab="Global_reactive_power", cex.lab=1.0, cex.axis=1.0)

dev.off()