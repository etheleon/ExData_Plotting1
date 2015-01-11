#!/usr/bin/env Rscript
library(R.utils)
library(lubridate)
library(dplyr)

if(!file.exists("household_power_consumption.txt"))
{
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household.zip", method="curl")
    unzip("household.zip")
}

df = read.table("household_power_consumption.txt",sep=";",h=T, stringsAsFactors=F)
df$Date = as.Date(df$Date, format='%d/%m/%Y')

df$dayOfWeek = weekdays(df$Date)

df.datesOfInterest = df %>% 
filter(Date >= "2007-02-01" & Date <= "2007-02-02")

df.datesOfInterest$dateTime = with(df.datesOfInterest, as.POSIXct(paste(Date, Time)))

png("plot3.png")
attach(df.datesOfInterest)
plot(y=Sub_metering_1, x=dateTime, type="l",
ylab="Global Active Power (kilowatts)", xlab="")
lines(y=Sub_metering_2, x=dateTime,col='Red')
lines(y=Sub_metering_3, x=dateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
              legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
detach(df.datesOfInterest)
dev.off()

