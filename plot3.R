## 
## R script to create plot3.PNG
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

# Plot 3
png(file="plot3.png",width=480,height=480)
with(ds, plot(ds$Datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Engergy sub metering"))
with(ds, points(ds$Datetime, Sub_metering_1, type = "s", xlab = "", ylab = ""))
with(ds, points(ds$Datetime, Sub_metering_2, type = "s", col = "red", xlab = "", ylab = ""))
with(ds, points(ds$Datetime, Sub_metering_3, type = "s", col = "blue", xlab = "", ylab = ""))
# The commented code is cor screen device check
# legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1), ncol = 1,
#       cex = 0.75, x.intersp = 0.5, y.intersp=0.5, text.width = strwidth("legend"),
#       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1), ncol = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()