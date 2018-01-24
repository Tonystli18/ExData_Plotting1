## 
## R script to create plot4.PNG
##

# Please make sure the file "" has been put into your current working directory
library(lubridate)
# read data into R
datafile <- file.path(getwd(), "household_power_consumption.txt")
df <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?", colClasses = 
                     c("character", "character", "numeric",  "numeric",
                       "numeric", "numeric", "numeric", "numeric", "numeric"))
# get data only for "01/02/2007" and "02/02/2007"
ds <- df[(dmy(df$Date) == dmy("01/02/2007") | dmy(df$Date) == dmy("02/02/2007")), ]
# add a new column which combine Date and Time
dt <- data.frame(Datetime = strptime(paste(ds$Date, ds$Time), format = "%d/%m/%Y %H:%M:%S"))
ds <- cbind(dt, ds)

# Plot 4
png(file="plot4.png",width=480,height=480)
par(mfrow = c(2,2))
# picture on topleft
with(ds, plot(ds$Datetime, Global_active_power, type = "s", xlab = "", 
              ylab = "Global Active Power(kilowatts)"))
# picture on topright
with(ds, plot(ds$Datetime, Voltage, type = "s", xlab = "datetime", ylab = "Voltage"))

# picture on bottom left
with(ds, plot(ds$Datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Engergy sub metering"))
with(ds, points(ds$Datetime, Sub_metering_1, type = "s", xlab = "", ylab = ""))
with(ds, points(ds$Datetime, Sub_metering_2, type = "s", col = "red", xlab = "", ylab = ""))
with(ds, points(ds$Datetime, Sub_metering_3, type = "s", col = "blue", xlab = "", ylab = ""))
# The commented code is for screen device check
#legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1), ncol = 1, bty = "n",
#       cex = 0.75, x.intersp = 0.5, y.intersp= 0.1, text.width = strwidth("legend"),
#       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1), ncol = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# picture on bottom right
with(ds, plot(ds$Datetime, Global_reactive_power, type = "s", xlab = "datetime", 
              ylab = "Global Reactive Power"))
dev.off()