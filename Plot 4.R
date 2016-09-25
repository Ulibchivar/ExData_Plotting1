      ################Dowload data##########

setwd("c:/Coursera/Exploratory Data Analysis")
if(!file.exists('data')) dir.create('data')
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "c:/Coursera/Exploratory Data Analysis/data/household_power_consumption.zip"
download.file(url, destfile)
unzip('./data/household_power_consumption.zip', exdir = './data')


        ################read data in################
location <- file('./data/household_power_consumption.txt')
data <- read.table(text = grep("^[1,2]/2/2007",readLines(location),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

# looking at data
head(data)

        ################dates 2007-02-01 and 2007-02-02################
newdata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# looking at data
head(newdata)
        ################ Plot 4 ################

datetime <- strptime(paste(newdata$Date, newdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
Global_active_power <- as.numeric(newdata$Global_active_power)
Golbal_reactive_power <- as.numeric(newdata$Global_reactive_power)
voltage <- as.numeric(newdata$Voltage)
sub_metering1 <- as.numeric(newdata$Sub_metering_1)
sub_metering2 <- as.numeric(newdata$Sub_metering_2)
sub_metering3 <- as.numeric(newdata$Sub_metering_3)
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_metering2, type="l", col="red")
lines(datetime, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(datetime, Golbal_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()