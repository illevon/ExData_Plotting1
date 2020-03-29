
# load libraries
library(lubridate) #for time and date variables
library(dplyr) 

# if you want to reproduce the graph, you may have to change the path to data file!
# NAs are recorded as "?"
qd<-read.delim("./04data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# look at the date:
head(qd)

# change time and date format, create datetime variable:
qd$datetime<-dmy_hms(paste(qd$Date, qd$Time, sep =""))
qd<-select(qd, -c(Time,Date))

# according to project instructions we will only be using 
# data from the dates 2007-02-01 and 2007-02-02. Therefore:
qd<-subset(qd, datetime>= "2007-02-01" & datetime<= "2007-02-02")

# Open png device
png(filename = "./04data/plot1.png", width=480, height=480)

# create plot
hist(qd$Global_active_power, main="Global Active Power", col = "red", xlab="Global Active Power (kilowatts)")

# close device
dev.off()
