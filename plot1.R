# plot1.R
# histogram showing the frequency of different
# buckets of globabl Active Power in kilowatts

# download the zip folder and extract the data
temp <- tempfile(fileext = ".txt")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE, na.strings = "?")
unlink(temp)

# convert Date column from factor to date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# subset to only days 2007-02-01 and 2007-02-02 for histogram
histData <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

# create the histogram in a png file
png(filename = "plot1.png", height = 480, width = 480)
hist(histData$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()