setwd("D:/00 Important/10 YORBIT/201 EDA/exdata_data_household_power_consumption")
#Load and clean the table
df <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";",
                 colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Format Date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Filter - 1st Feb 2007 to 2nd Feb 2007
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Ignore incomplete data
df <- df[complete.cases(df),]

# Frame one column for Data and Time column
dateTime <- paste(df$Date, df$Time)

# Naming the vector
dateTime <- setNames(dateTime, "DateTime")

# Remove the Date and Time column
df <- df[ ,!(names(df) %in% c("Date","Time"))]

# Add newly created DateTime column
df <- cbind(dateTime, df)

# Format the dateTime Column
df$dateTime <- as.POSIXct(dateTime)


dev.copy(png,"plot2.png", width=480, height=480)
plot(df$Global_active_power~df$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
# Save file and close device
dev.off()
