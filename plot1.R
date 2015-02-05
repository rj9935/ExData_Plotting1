## This script reads in the UCI Machine Learning repositiory individual
## household electric power consumption dataset described in the EDA
## course project 1 and outputs the required plot1.png chart

## Step 1: Set everything up.
## --------------------------------------------------------------------

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

## Step 3: Subset and clean the data set and clear memory
## ---------------------------------------------------------------------

## Subset according to dates required and clean up memory
dataSubSet      <- dataSet[dataSet$Date=="1/2/2007"|dataSet$Date=="2/2/2007",]
rm(dataSet)
gc()

## Step 4: Draw the histogram 
## ---------------------------------------------------------------------

## Send a copy to the plot1.png output file in the current directory
png("plot1.png", width=480, height=480)

## Set the margins - for transparent background fill just add ,bg=NA .
par(mar=c(5.0, 4.7, 3.5, 0.7))

hist(dataSubSet$Global_active_power, breaks=12, col="red", 
            main="Global Active Power", xlab="Global Active Power (kilowatts)", 
                    ylab="Frequency", cex.lab=1.0, cex.axis=1.0, cex.main=1.0)
dev.off()