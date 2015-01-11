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

df.datesOfInterest = df %>% 
filter(Date >= "2007-02-01" & Date <= "2007-02-02")

df.datesOfInterest$dateTime = with(df.datesOfInterest, as.POSIXct(paste(Date, Time)))

#default is 480x480 pixels
png("plot1.png")
with(
     df.datesOfInterest, hist(as.numeric(as.character(Global_active_power)), 
                              col="red", 
                              main="Global Active Power")
     )
dev.off()
