library(data.table)
dat <- fread("household_power_consumption.txt", sep=";", na.strings="?", 
             skip="1/2/2007", colClasses=c("character", "character", "numeric", 
                                           "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric"))
dat[,V1:=as.Date(V1,"%d/%m/%Y")]
datclean <- rbind(dat[V1=="2007-02-01"], dat[V1=="2007-02-02"])
datclean[,V3:=as.numeric(V3)]
datclean[,V4:=as.numeric(V4)]
datclean[,V5:=as.numeric(V5)]
datclean[,V7:=as.numeric(V7)]
datclean[,V8:=as.numeric(V8)]
datclean[["V2"]] <- strptime(paste(datclean[["V1"]],
                                   datclean[["V2"]]),"%Y-%m-%d %H:%M:%S")

png(file = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#graph 1
with(datclean, plot(V2,V3, type="l", xlab="", 
                    ylab="Global Active Power"))
#graph 2
with(datclean, plot(V2,V5, type="l", xlab="datetime", ylab="Voltage"))
#graph 3
plot(datclean$V2,datclean$V7,type="l",ylab="Energy submetering",xlab="")
points(datclean$V2,datclean$V8,type="l",col="red")
points(datclean$V2,datclean$V9,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"),bty="n")
#graph 4
with(datclean, plot(V2,V4, type="l", xlab="datetime",
                    ylab="Global_reactive_power"))
dev.off()
