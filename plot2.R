library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.txt"

##Check if household power consumption file exists, download it if it doesn't.  
##After unzipping the text file, remove the original ZIP file.
if (!file.exists(filename)) {
      download.file(url, destfile = "hpc.zip")
      unzip("hpc.zip")
      file.remove("hpc.zip")
  }



#starting on February 1, 2007, read next 2880 minutes' (48 hours') worth of data
data <- fread(filename, na.strings = "?", skip = "1/2/2007", nrows = 2880)
setnames(data, names(fread(filename, nrows = 1)))

#create new column that combines date and time columns
data[,DateTime:= as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))]

##Plot directly to PNG.  Plotting to console then copying to PNG results in legend getting cut off
##and some other graphical artifacts
png("plot2.png", width=480, height=480)
par(bg = "transparent")

par(mfcol = c(1,1))

plot(data[,DateTime], data[,Global_active_power], type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()