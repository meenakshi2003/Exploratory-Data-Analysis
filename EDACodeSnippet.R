setwd("D:/00 Important/10 YORBIT/201 EDA/exdata_data_household_power_consumption")
#Load and clean the table
df <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";",
                 colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
df <- df[complete.cases(df),]

## Combine Date and Time column
dateTime <- paste(df$Date, df$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
df <- df[ ,!(names(df) %in% c("Date","Time"))]

## Add DateTime column
df <- cbind(dateTime, df)

## Format dateTime Column
df$dateTime <- as.POSIXct(dateTime)

## Create the histogram
hist(df$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
## Save file and close device
#dev.copy(png,"plot1.png", width=480, height=480)
#dev.off()
## Create Plot 2
plot(df$Global_active_power~df$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
#dev.copy(png,"plot2.png", width=480, height=480)
#dev.off()
## Create Plot 3
with(df, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Saving to file
#dev.copy(png, file="plot3.png", height=480, width=480)
#dev.off()
## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
## Saving to file
#dev.copy(png, file="plot4.png", height=480, width=480)
#dev.off()
