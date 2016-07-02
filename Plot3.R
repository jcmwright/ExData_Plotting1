##set working directory and create local file structure
setwd("J:/Data_Science_Specialization/Exploratory_Data_Analysis/Week_1") #Change this path to active working directory to run file.
if(!file.exists("./data")){dir.create("./data")}

##get data and unzip in the appropriate location
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "ElectricPowerConsumption.zip")
unzip("ElectricPowerConsumption.zip", exdir = "./data")

##Read files in to R
bigdata <- read.table("./data/household_power_consumption.txt", na.strings = "?", header = TRUE, stringsAsFactors = FALSE, comment.char = "", sep = ";", check.names = FALSE)
bigdata$Date <- as.Date(bigdata$Date, format = "%d/%m/%Y") #change Date column to a date class

##Subset data for dates indicated (2007-02/01 to 2007/02-02)
twodaysdata <- subset(bigdata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02")) 
rm(bigdata) ## space saver

#Create plot
twodaysdata$datetime <- as.POSIXct(paste(twodaysdata$Date, twodaysdata$Time, sep = " ")) #convert the time and date columns to a single timestamp
plot(twodaysdata$datetime, twodaysdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering", col="black")
lines(twodaysdata$datetime, twodaysdata$Sub_metering_2, col = "red")
lines(twodaysdata$datetime, twodaysdata$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), border = "black", col=c("black", "red", "blue"), lty = 1, lwd = 2.5)
#Save to png 480x480 px
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
