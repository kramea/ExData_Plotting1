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

## Global Active Power is plotted against time and saved as png file
plot(final_power[,10], final_power[,3], type="l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png") 
dev.off()