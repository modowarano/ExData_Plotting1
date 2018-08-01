library(dplyr)


data <- read.table("household_power_consumption.txt", header = TRUE, sep =";") %>%
  mutate(Date = as.Date(Date, '%d/%m/%Y')) %>%
  mutate(Time = as.POSIXct(strptime(paste(Date, ' ', Time), '%Y-%m-%d %H:%M:%S')))

data2 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

data2$Sub_metering_1 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_2 <- as.numeric(as.character(data2$Sub_metering_2))
data2$Sub_metering_3 <- as.numeric(as.character(data2$Sub_metering_3))

data2$Voltage <- as.numeric(as.character(data2$Voltage))

data2$Global_reactive_power <- as.numeric(as.character(data2$Global_reactive_power))

par(mfcol = c(2,2))


plot(data2$Time,
     data2$Global_active_power,
     xlim=c(start, end),
     xaxt="n",
     type="l",
     xlab="",
     ylab="Energy Sub Metering"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

plot(data2$Time,
     data2$Sub_metering_1,
     xlim=c(start, end),
     xaxt="n",
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)"
)

lines(data2$Time, data2$Sub_metering_2, col="red")
lines(data2$Time, data2$Sub_metering_3, col="blue")

legend("topright",legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=c(1, 1, 1),bty = "n",
       x.intersp = 0.15, y.intersp = 0.15, cex = 0.75) 

axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

plot(data2$Time,
    data2$Voltage,
    xlim=c(start, end),
    xaxt="n",
    type="l",
    xlab="datatime",
    ylab="Voltage"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

plot(data2$Time,
     data2$Global_reactive_power,
     xlim=c(start, end),
     xaxt="n",
     type="l",
     xlab="datatime",
     ylab="Global_reactive_power"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

dev.copy(png , file = "plot4.png", width=480, height=480, units='px')
dev.off()
