# Load library to work with dates
library("lubridate")

# Download the data, unzip it, read it in and unlink the zipfile
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", stringsAsFactors=FALSE, header = TRUE)
unlink(temp)

# Create a DateTime column and parse the DateTimes
data$DateTime <- parse_date_time(paste(data$Date, data$Time), "d/m/Y H:M:S")
# Subset the dataframe to contain data from 2007-02-01 and 2007-02-02
workonset <- subset(data,  parse_date_time("03/02/2007 00:00:00", "d/m/Y H:M:S") > DateTime & DateTime >= parse_date_time("01/02/2007 00:00:00", "d/m/Y H:M:S"))


# Plot three lines in one graph
plot(workonset$DateTime, as.numeric(workonset$Sub_metering_1), xlab="", ylab="Energy sub metering", col = "Black", main = "", type = "l")
lines(workonset$DateTime, as.numeric(workonset$Sub_metering_2), col = "Red")
lines(workonset$DateTime, as.numeric(workonset$Sub_metering_3), col = "Blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = c(1,1), col=c("Black","Red", "Blue"), cex = 0.5 )
dev.copy(png,'plot3.png')
dev.off()