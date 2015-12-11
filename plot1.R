# Load library to work with dates
library("lubridate")

# Download the data, unzip it, read it in and unlink the zipfile
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", stringsAsFactors=FALSE, header = TRUE)
unlink(temp)

# Parse the dates
data$Date <- parse_date_time(data$Date, "d/m/Y")
# Subset the dataframe to contain data from 2007-02-01 and 2007-02-02
workonset <- subset(data, Date == parse_date_time("01/02/2007", "d/m/Y") | Date == parse_date_time("02/02/2007", "d/m/Y"))

# Plot a histogram, rename the x axis and y axis, color it red and change the title, save it as a png file
hist(as.numeric(workonset$Global_active_power), xlab="Global Active Power (kilowatts)", ylab="Frequency", col = "Red", main = "Global Active Power")
dev.copy(png,'plot1.png')
dev.off()