## 
## R script to create plot2.PNG
##

# Please make sure the file "" has been put into your current working directory
library(lubridate)
# read data into R
if (!exists("ds")){
    datafile <- file.path(getwd(), "household_power_consumption.txt")
    df <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?", colClasses = 
                         c("character", "character", "numeric",  "numeric",
                           "numeric", "numeric", "numeric", "numeric", "numeric"))
    # get data only for "01/02/2007" and "02/02/2007"
    ds <- df[(dmy(df$Date) == dmy("01/02/2007") | dmy(df$Date) == dmy("02/02/2007")), ]
    # add a new column which combine Date and Time
    dt <- data.frame(Datetime = strptime(paste(ds$Date, ds$Time), format = "%d/%m/%Y %H:%M:%S"))
    ds <- cbind(dt, ds)
}
# Set locale to to be English
Sys.setlocale("LC_ALL","English")

# Plot 2
png(file="plot2.png",width=480,height=480)
with(ds, plot(ds$Datetime, Global_active_power, type = "s", xlab = "", 
              ylab = "Global Active Power(kilowatts)"))
dev.off()