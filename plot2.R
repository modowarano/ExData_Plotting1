library(dplyr)


data <- read.table("household_power_consumption.txt", header = TRUE, sep =";") %>%
    mutate(Date = as.Date(Date, '%d/%m/%Y')) %>%
    mutate(Time = as.POSIXct(strptime(paste(Date, ' ', Time), '%Y-%m-%d %H:%M:%S')))

data2 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

start = as.POSIXct(strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
end   = as.POSIXct(strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S"))
plot(data2$Time,
     data2$Global_active_power,
     xlim=c(start, end),
     xaxt="n",
     type="l",
     xlab="",
     ylab="Energy Sub Metering"
)
axis.POSIXct(1, at=seq(startDay, endDay, by="day"), format="%a")

dev.copy(png , file = "plot2.png", width=480, height=480, units='px')
dev.off()