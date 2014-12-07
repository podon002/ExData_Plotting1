library(data.table)
dat <- fread("household_power_consumption.txt", sep=";", na.strings="?", 
             skip="1/2/2007", colClasses=c("character", "character", "numeric", 
                                           "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric"))
dat[,V1:=as.Date(V1,"%d/%m/%Y")]
datclean <- rbind(dat[V1=="2007-02-01"], dat[V1=="2007-02-02"])
datclean[,V3:=as.numeric(V3)]
par(mfrow=c(1,1))
with(datclean, hist(V3, col = "red", main = "Global Active Power", 
                    xlab="Global Active Power (kilowatts)"))
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
