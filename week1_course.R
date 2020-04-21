# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

##libraries
library(lubridate)
Sys.setlocale(category="LC_ALL", locale = "en_US.UTF-8")


## Read the file
data <- read.csv("household_power_consumption.txt", sep=";"
                 , colClasses = "character")
# convert the dates with lubridate
Dates <- dmy(data$Date)
data$Date2 <- Dates
# subset the data set only to the two relevant days
data <- subset(data, Date2 == "2007-02-01" | Date2 =="2007-02-02")
data$Time2 <- hms(data$Time)
data$dat_tim <- paste(data$Date, data$Time)
data$dat_time_combined <- dmy_hms(data$dat_tim)
# For analysis use: Date2, Time2, dat_time_combined

# Plot 1 - histogram of global active power
jpeg("Plot1.jpg", width = 700, height = 700)
hist(as.numeric(data$Global_active_power), col="red"
     ,xlab="Global Active Power (kilowatts)"
     ,breaks = 15
     ,main = "Global Active Power"
     )
dev.off()


# Plot 2 - GLobal Active Power development
jpeg("Plot2.jpg", width = 700, height = 700)
with(data, plot(dat_time_combined, as.numeric(Global_active_power)
                , type = "line"
                , xlab = ""
                , ylab = "Global Active Power (kilowatts)"
                ) 
     )
dev.off()

# Plot 3 
jpeg("Plot3.jpg", width = 700, height = 700)
with(data, {
       plot(dat_time_combined, as.numeric(Sub_metering_1), col="black", type="line"
            , xlab = ""
            , ylab = "Energy sub metering" )
       lines(dat_time_combined, as.numeric(Sub_metering_2), col="red")   
       lines(dat_time_combined, as.numeric(Sub_metering_3), col="blue", type="line")   
        }
    )
legend("topright"
, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
, col=c("black", "red", "blue")
, lty="solid")
dev.off()

# Plot 4
jpeg("Plot4.jpg", width = 700, height = 700)
par(mfrow=c(2,2))
with(data, plot(dat_time_combined, as.numeric(Global_active_power)
                , type = "line"
                , xlab = ""
                , ylab = "Global Active Power"
                ) 
        )

with(data, plot(dat_time_combined, as.numeric(Voltage)
                , type = "line"
                , xlab = ""
                , ylab = "Voltage"
                ) 
        )

with(data, {
        plot(dat_time_combined, as.numeric(Sub_metering_1), col="black", type="line"
             , xlab = ""
             , ylab = "Energy sub metering" )
        lines(dat_time_combined, as.numeric(Sub_metering_2), col="red")   
        lines(dat_time_combined, as.numeric(Sub_metering_3), col="blue", type="line")   
        }
        )
legend("topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col=c("black", "red", "blue")
       , lty="solid")


with(data, plot(dat_time_combined, as.numeric(Global_reactive_power)
                , type = "line"
                , xlab = ""
                , ylab = "Global Reactive Power"
) 
)
dev.off()



