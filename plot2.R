library(data.table)
dat <- fread("household_power_consumption.txt", sep=";", na.strings="?", 
             skip="1/2/2007", colClasses=c("character", "character", "numeric", 
                                           "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric"))
dat[,V1:=as.Date(V1,"%d/%m/%Y")]
datclean <- rbind(dat[V1=="2007-02-01"], dat[V1=="2007-02-02"])
datclean[,V3:=as.numeric(V3)]
datclean[["V2"]] <- strptime(paste(datclean[["V1"]],
                                   datclean[["V2"]]),"%Y-%m-%d %H:%M:%S")
par(mfrow=c(1,1))
with(datclean, plot(V2,V3, type="l", xlab="", 
                    ylab="Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()