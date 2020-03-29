
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
# data from the dates 2007-02-01 and 2007-02-02. But the resulting plot is not the
# same as specified in the instructions, since three days (2007-02-01, 2007-02-02,
# AND 2007-02-03) are necessary to reconstruct the plot. Therefore for this plot the dataset
# is subsetted in the following way:
qd<-subset(qd, datetime>= "2007-02-01" & datetime<= "2007-02-03")


# Open png device
png(filename = "./04data/plot3.png", width=480, height=480)

# create plot
plot(qd$Sub_metering_1~qd$datetime, type="l", ylab="Energy sub metering", xlab="")
points(qd$Sub_metering_2~qd$datetime, type="l", col = "red")
points(qd$Sub_metering_3~qd$datetime, type="l", col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1))

# close device
dev.off()
