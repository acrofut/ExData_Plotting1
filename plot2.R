# plot2.R
# line chart showing global active power over time

# download the zip folder and extract the data
temp <- tempfile(fileext = ".txt")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE, na.strings = "?")
unlink(temp)

# subset to only days 2007-02-01 and 2007-02-02 for line chart
chartData <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

# create a date-time column out of the Date and Time columns
chartData$dt <- cbind(paste(chartData$Date, chartData$Time))
chartData$dt <- strptime(chartData$dt, format='%m/%d/%Y %H:%M')

# plot the power over time
