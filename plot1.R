# Coursera's "Exploratory Data Analysis" - Course Project 1
# PLOT 1

# path for the local copy of the dataset, downloaded as needed
LOCALFILE <- 'power_consumption.zip'

# check if the dataset can be found locally, in order to avoid multiple downloads (19.7 Mb)
if (!file.exists(LOCALFILE)) {
  # file doesn't exist, downloads it
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=LOCALFILE)
}

# reads data from local copy of the dataset
pc.data = read.table(unz(LOCALFILE,"household_power_consumption.txt"), sep=";", header=TRUE)

# convert column 'Date' in an actual R date and subsets it
pc.data$Date = as.Date(pc.data$Date, format="%d/%m/%Y")
pc.subset = subset(pc.data, Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

# format column 'Time' as needed for the plots requested by Coursera (especially day names);
# locale is set for English to match the requested plot by Coursera
Sys.setlocale("LC_TIME", 'English')
times = paste(as.character(pc.subset$Date), as.character(pc.subset$Time), sep=" ")
pc.subset$Time = strptime(times, format="%Y-%m-%d %H:%M")

# convert character variables in numeric ones, for plotting
for (i in 3:9) {
 pc.subset[,i] = as.numeric(as.character(pc.subset[,i]))
}

# plot as requested to a PNG file; the requested width and height of (480, 480) is the default
png("plot1.png", bg="white")
hist(pc.subset$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
