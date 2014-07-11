setwd("/Users/kalaivanirameakubendran/datasciencecoursera/ExData_Plotting1")

##First, the household power consumption file is read as 'power' through read.table command
power <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## The date column from the file is stored as 'factor' class.
## This is converted to 'Date' class in order to subset our necessary rows
power[,1] <- as.Date(factor(power[,1]), format="%d/%m/%Y")

## The data for the given dates are extracted from the main file
power_sub <- subset(power, power$Date >= "2007-02-01" & power$Date <= "2007-02-02")

## Another column is created with the column name 'timestamp'
## This combines the 'Date' (column 1) and 'Time' (column 2) of the subset data
## The combined column 'timestamp' is conveted to POSIXlt in order to be used for future plots against time
## This is done because the data for the Time in column 2 is stored as 'factor' class
final_power <- within(power_sub, {timestamp=as.POSIXct(paste(Date, factor(Time)), tz="America/Los_Angeles", format="%Y-%m-%d %H:%M:%S")})

## There are three sub-metering columns in the data. 
## The first plot is created with default color, and the rest are added with the specified colors
with(final_power, plot(timestamp,Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(final_power, lines(timestamp, Sub_metering_2, col="red"))
with(final_power, lines(timestamp, Sub_metering_3, col="blue"))

## Legend is created on the topright, and the plot is saved as png file
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), cex=0.8, legend = colnames(final_power)[7:9])
dev.copy(png, file = "plot3.png") 
dev.off()
