library(dplyr)


data <- read.table("household_power_consumption.txt", header = TRUE, sep =";") %>%
  mutate(Date = as.Date(Date, '%d/%m/%Y')) %>%
  mutate(Time = as.POSIXct(strptime(paste(Date, ' ', Time), '%Y-%m-%d %H:%M:%S')))

data2 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
hist(data2$Global_active_power, col = 2, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png , file = "plot1.png", width=480, height=480, units='px')
dev.off()