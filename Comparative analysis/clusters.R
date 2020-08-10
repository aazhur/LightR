library('R.matlab')
library('ggplot2')
library('plotrix')
library('cowplot')

path <- getwd()
file <- paste(path,"/matrix1.csv", sep='')
M1 <- read.csv(file)

file <- paste(path,"/matrix2.csv", sep='')
M2 <- read.csv(file)

file <- paste(path,"/matrix3.csv", sep='')
M3 <- read.csv(file)

M <- rbind(M1, M2, M3)
M$Clust <- as.factor(M$Clust)
Box <- rbind(M1, M2, M3)

M$Cluster <- interaction(M$Type, M$Clust)
d <- data.frame(aggregate(M$Amplitude, list(M$Cluster), mean))
names(d) <- c("Cluster","xmean")
xse <- aggregate(M$Amplitude, list(M$Cluster), std.error); d$xse <- 2*xse[,2]
ymean <- aggregate(M$Period, list(M$Cluster), mean); d$ymean <- ymean[,2]
yse <- aggregate(M$Period, list(M$Cluster), std.error); d$yse <- 2*yse[,2]
d$type <- c(rep(c("Control", "ROCK", "MLCK"),5))
d$clust <- as.character(rep(1:5, each = 3))
 
ggplot() +
  geom_point(data = M, aes(x=Amplitude, y=Period, colour=Type, shape=Clust), alpha = 0.2, size = 3) +
  geom_errorbar(data = d, aes(x=xmean, colour=type, ymin=(ymean-yse), ymax=(ymean+yse)), width = 0.05) +
  geom_errorbarh(data = d, aes(y=ymean, colour=type, xmin=(xmean-xse), xmax=(xmean+xse)), height = 0.5) +
  geom_point(data = d, aes(x=xmean, y=ymean, colour=type, shape=clust), size = 3)

# d <- data.frame(aggregate(M$Amplitude, list(M$Cluster), mean))
# names(d) <- c("Cluster","xmean")
# xse <- aggregate(M$Amplitude, list(M$Cluster), std.error); d$xse <- 2*xse[,2]
# ymean <- aggregate(M$Frequency, list(M$Cluster), mean); d$ymean <- ymean[,2]
# yse <- aggregate(M$Frequency, list(M$ClusterF), std.error); d$yse <- 2*yse[,2]
# d$type <- c(rep(c("Control", "ROCK", "MLCK"),6))
# d$clust <- as.character(rep(1:6, each = 3))
# 
# ggplot() +
#   geom_point(data = M, aes(x=Amplitude, y=Frequency, colour=Type, shape=Clust), alpha = 0.2, size = 3) +
#   geom_errorbar(data = d, aes(x=xmean, colour=type, ymin=(ymean-yse), ymax=(ymean+yse)), width = 0.05) +
#   geom_errorbarh(data = d, aes(y=ymean, colour=type, xmin=(xmean-xse), xmax=(xmean+xse)), height = 0.05) +
#   geom_point(data = d, aes(x=xmean, y=ymean, colour=type, shape=clust), size = 3)
# 
# Box <- M[M$Amplitude < 0.6 & M$Period > 5 & M$Period <= 25,]

d <- data.frame(aggregate(Box$Amplitude, list(Box$Type), mean))
names(d) <- c("Cluster","xmean")
xse <- aggregate(Box$Amplitude, list(Box$Type), std.error); d$xse <- 2*xse[,2]
ymean <- aggregate(Box$Frequency, list(Box$Type), mean); d$ymean <- ymean[,2]
yse <- aggregate(Box$Frequency, list(Box$Type), std.error); d$yse <- 2*yse[,2]

p1 <- ggplot() +
  geom_point(data = Box, aes(x=Amplitude, y=Frequency, colour=Type), alpha = 0.5, size = 3) +
  geom_errorbar(data = d, aes(x=xmean, colour=Cluster, ymin=(ymean-yse), ymax=(ymean+yse)), width = 0.05) +
  geom_errorbarh(data = d, aes(y=ymean, colour=Cluster, xmin=(xmean-xse), xmax=(xmean+xse)), height = 0.05) +
  geom_point(data = d, aes(x=xmean, y=ymean, colour=Cluster), size = 3) 

d <- data.frame(aggregate(Box$Amplitude, list(Box$Type), mean))
names(d) <- c("Cluster","xmean")
xse <- aggregate(Box$Amplitude, list(Box$Type), std.error); d$xse <- 2*xse[,2]
ymean <- aggregate(Box$Period, list(Box$Type), mean); d$ymean <- ymean[,2]
yse <- aggregate(Box$Period, list(Box$Type), std.error); d$yse <- 2*yse[,2]

p2 <- ggplot() +
  geom_point(data = Box, aes(x=Amplitude, y=Period, colour=Type), alpha = 0.5, size = 3) +
  geom_errorbar(data = d, aes(x=xmean, colour=Cluster, ymin=(ymean-yse), ymax=(ymean+yse)), width = 0.05) +
  geom_errorbarh(data = d, aes(y=ymean, colour=Cluster, xmin=(xmean-xse), xmax=(xmean+xse)), height = 0.05) +
  geom_point(data = d, aes(x=xmean, y=ymean, colour=Cluster), size = 3)

d <- data.frame(aggregate(Box$Amplitude, list(Box$Type), mean))
names(d) <- c("Cluster","xmean")
xse <- aggregate(Box$Amplitude, list(Box$Type), std.error); d$xse <- 2*xse[,2]
ymean <- aggregate(Box$Phase, list(Box$Type), mean); d$ymean <- ymean[,2]
yse <- aggregate(Box$Phase, list(Box$Type), std.error); d$yse <- 2*yse[,2]

p3 <- ggplot() +
  geom_point(data = Box, aes(x=Amplitude, y=Phase, colour=Type), alpha = 0.5, size = 3) +
  geom_errorbar(data = d, aes(x=xmean, colour=Cluster, ymin=(ymean-yse), ymax=(ymean+yse)), width = 0.05) +
  geom_errorbarh(data = d, aes(y=ymean, colour=Cluster, xmin=(xmean-xse), xmax=(xmean+xse)), height = 0.05) +
  geom_point(data = d, aes(x=xmean, y=ymean, colour=Cluster), size = 3)

plot_grid(p1,p2,p3,
          labels = c("Frequency", "Period", "Phase"),
          ncol = 3, nrow = 1)

write.csv(Box,"box.csv", row.names = FALSE)




