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

## The following command divides the plot area into 4 areas (2 rows, 2 columns)
par(mfrow=c(2,2))

# Plot a 
with(final_power, plot(timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

# Plot b
with(final_power, plot(timestamp, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# Plot c
with(final_power, plot(timestamp,Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
with(final_power, lines(timestamp, Sub_metering_2, col="red"))
with(final_power, lines(timestamp, Sub_metering_3, col="blue"))
legend("topright", inset=c(0.03,0), lty=c(1,1), bty="n", cex=0.7, col = c("black", "red", "blue"), legend = colnames(final_power)[7:9])

# Plot d
with(final_power, plot(timestamp, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power"))

#The plot layout is saved as png file
dev.copy(png, file = "plot4.png") 
dev.off()
