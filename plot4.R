# plot4.R
# 2x2 matrix of 4 charts showing global active power, voltage, energy sub metering, and global reactive power

# download the zip folder and extract the data
temp <- tempfile(fileext = ".txt")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE, na.strings = "?")
unlink(temp)

# subset to only days 2007-02-01 and 2007-02-02 for line chart
chartData <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

# create a date-time column out of the Date and Time columns
chartData$dt <- cbind(paste(chartData$Date, chartData$Time))
chartData$dt <- strptime(chartData$dt, format='%d/%m/%Y %H:%M')

# create the plots and save to a png file
png(filename = "plot4.png", height = 480, width = 480)

par(mfrow=c(2,2))  # for a 2x2 matrix

plot(range(chartData$dt), range(chartData$Global_active_power), type = "n", xlab = "", ylab = "Global Active Power")
lines(chartData$dt, chartData$Global_active_power, col = "black", lty = 1)

plot(range(chartData$dt), range(chartData$Voltage), type = "n", xlab = "datetime", ylab = "Voltage")
lines(chartData$dt, chartData$Voltage, col = "black", lty = 1)

plot(range(chartData$dt), range(chartData$Sub_metering_1), type = "n", xlab = "", ylab = "Energy sub metering")
lines(chartData$dt, chartData$Sub_metering_1, col = "black")
lines(chartData$dt, chartData$Sub_metering_2, col = "red")
lines(chartData$dt, chartData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))

plot(range(chartData$dt), range(chartData$Global_reactive_power), type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(chartData$dt, chartData$Global_reactive_power, col = "black", lty = 1)

dev.off()