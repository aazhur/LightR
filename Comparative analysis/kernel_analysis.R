library('R.matlab')
library('ggplot2')
library('plotrix')
library('cowplot')
library('diptest')
library('EnvStats')

path <- getwd()

file <- paste(path,"/Data/Data13.mat", sep='')
M <- readMat(file)
X11 <- M$X11; X12 <- M$X12; X13 <- M$X13; X14 <- M$X14; X15 <- M$X15
x11 <- M$x11; x12 <- M$x12; x13 <- M$x13; x14 <- M$x14; x15 <- M$x15
xm11 <- M$xm11; xm12 <- M$xm12; xm13 <- M$xm13
T1 <- M$T1; vhist1 <- as.vector(as.double(M$vhist1)); 
vhist1 <- data.frame(vhist1, rep('Control', length(M$vhist1))); names(vhist1) <- c('v','type')
L1 <- as.vector(as.double(M$L1)); TF1 <- as.vector(as.double(M$TF1)); 
MaxA1 <- as.vector(as.double(M$MaxA1)); MinA1 <- as.vector(as.double(M$MinA1))
F1 <- as.data.frame(M$F1); T1 <- as.data.frame(M$T1)
names(F1) <- c("Max_max","Max_min","Min_max","Min_min","First_max","First_min","Median_max","Median_min","Mean_max","Mean_min")
names(T1) <- c("TMax_max","TMax_min","TMin_max","TMin_min","TFirst_max","TFirst_min","TMedian_max","TMedian_min","TMean_max","TMean_min")
F1 <- cbind(F1,T1,rep("Control", 20))
colnames(F1)[21] <- "Type"

file <- paste(path,"/Data/Data23.mat", sep='')
M <- readMat(file)
X21 <- M$X21; X22 <- M$X22; X23 <- M$X23; X24 <- M$X24; X25 <- M$X25
x21 <- M$x21; x22 <- M$x22; x23 <- M$x23; x24 <- M$x24; x25 <- M$x25
xm21 <- M$xm21; xm22 <- M$xm22; xm23 <- M$xm23
T2 <- M$T2; vhist2 <- as.vector(as.double(M$vhist2)); 
vhist2 <- data.frame(vhist2, rep('ROCK', length(M$vhist2))); names(vhist2) <- c('v','type')
L2 <- as.vector(as.double(M$L2)); TF2 <- as.vector(as.double(M$TF2)); 
MaxA2 <- as.vector(as.double(M$MaxA2)); MinA2 <- as.vector(as.double(M$MinA2))
F2 <- as.data.frame(M$F2); T2 <- as.data.frame(M$T2)
names(F2) <- c("Max_max","Max_min","Min_max","Min_min","First_max","First_min","Median_max","Median_min","Mean_max","Mean_min")
names(T2) <- c("TMax_max","TMax_min","TMin_max","TMin_min","TFirst_max","TFirst_min","TMedian_max","TMedian_min","TMean_max","TMean_min")
F2 <- cbind(F2,T2,rep("ROCK", 24))
colnames(F2)[21] <- "Type"

file <- paste(path,"/Data/Data33.mat", sep='')
M <- readMat(file)
X31 <- M$X31; X32 <- M$X32; X33 <- M$X33; X34 <- M$X34; X35 <- M$X35
x31 <- M$x31; x32 <- M$x32; x33 <- M$x33; x34 <- M$x34; x35 <- M$x35 
xm31 <- M$xm31; xm32 <- M$xm32; xm33 <- M$xm33
T3 <- M$T3; vhist3 <- as.vector(as.double(M$vhist3)); 
vhist3 <- data.frame(vhist3, rep('MLCK', length(M$vhist3))); names(vhist3) <- c('v','type')
L3 <- as.vector(as.double(M$L3)); TF3 <- as.vector(as.double(M$TF3)); 
MaxA3 <- as.vector(as.double(M$MaxA3)); MinA3 <- as.vector(as.double(M$MinA3))
F3 <- as.data.frame(M$F3); T3 <- as.data.frame(M$T3)
names(F3) <- c("Max_max","Max_min","Min_max","Min_min","First_max","First_min","Median_max","Median_min","Mean_max","Mean_min")
names(T3) <- c("TMax_max","TMax_min","TMin_max","TMin_min","TFirst_max","TFirst_min","TMedian_max","TMedian_min","TMean_max","TMean_min")
F3 <- cbind(F3,T3,rep("MLCK", 20))
colnames(F3)[21] <- "Type"

MM <- rbind(F1,F2,F3)
MM$Mean_dif <- MM$Mean_max - MM$Mean_min
MM$Median_dif <- MM$Median_max - MM$Median_min

pmax <- ggplot(MM, aes(x=Type, y=Mean_dif, color = Type)) +
  geom_boxplot() + geom_point(alpha = 0.5)
pmin <- ggplot(MM, aes(x=Type, y=Median_dif, color = Type)) +
  geom_boxplot() + geom_point(alpha = 0.5)

plot_grid(pmax, pmin,
          labels = c("Mean difference", "Median Difference"),
          ncol = 2, nrow = 1)

d1 <- data.frame(X11,rep("Control", 20))
names(d1) <- c("Frequency","Amplitude","Phase","Shift","Type")
d2 <- data.frame(X21,rep("ROCK", 24))
names(d2) <- c("Frequency","Amplitude","Phase","Shift","Type")
d3 <- data.frame(X31,rep("MLCK", 20))
names(d3) <- c("Frequency","Amplitude","Phase","Shift","Type")
cos1 <- rbind(d1, d2, d3)

d1 <- data.frame(X12,rep("Control", 20))
names(d1) <- c("Frequency1","Frequency2","Amplitude1","Amplitude2","Phase1","Phase2","Shift","Type")
d2 <- data.frame(X22,rep("ROCK", 24))
names(d2) <- c("Frequency1","Frequency2","Amplitude1","Amplitude2","Phase1","Phase2","Shift","Type")
d3 <- data.frame(X32,rep("MLCK", 20))
names(d3) <- c("Frequency1","Frequency2","Amplitude1","Amplitude2","Phase1","Phase2","Shift","Type")
cos2 <- rbind(d1, d2, d3)

d1 <- data.frame(X13,rep("Control", 20))
names(d1) <- c("Frequency1","Frequency2","Frequency3","Amplitude1","Amplitude2","Amplitude3","Phase1","Phase2","Phase3","Shift","Type")
d2 <- data.frame(X23,rep("ROCK", 24))
names(d2) <- c("Frequency1","Frequency2","Frequency3","Amplitude1","Amplitude2","Amplitude3","Phase1","Phase2","Phase3","Shift","Type")
d3 <- data.frame(X33,rep("MLCK", 20))
names(d3) <- c("Frequency1","Frequency2","Frequency3","Amplitude1","Amplitude2","Amplitude3","Phase1","Phase2","Phase3","Shift","Type")
cos3 <- rbind(d1, d2, d3)

d1 <- data.frame(X14,rep("Control", 20))
names(d1) <- c("Frequency1","Frequency2","Frequency3","Frequency4","Amplitude1","Amplitude2","Amplitude3","Amplitude4","Phase1","Phase2","Phase3","Phase4","Shift","Type")
d2 <- data.frame(X24,rep("ROCK", 24))
names(d2) <- c("Frequency1","Frequency2","Frequency3","Frequency4","Amplitude1","Amplitude2","Amplitude3","Amplitude4","Phase1","Phase2","Phase3","Phase4","Shift","Type")
d3 <- data.frame(X34,rep("MLCK", 20))
names(d3) <- c("Frequency1","Frequency2","Frequency3","Frequency4","Amplitude1","Amplitude2","Amplitude3","Amplitude4","Phase1","Phase2","Phase3","Phase4","Shift","Type")
cos4 <- rbind(d1, d2, d3)

d1 <- data.frame(rep("Control", 20),1:20,X15)
names(d1) <- c("Type","Id","Frequency1","Frequency2","Frequency3","Frequency4","Frequency5","Amplitude1","Amplitude2","Amplitude3","Amplitude4","Amplitude5","Phase1","Phase2","Phase3","Phase4","Phase5","Shift")
d2 <- data.frame(rep("ROCK", 24),1:24,X25)
names(d2) <- c("Type","Id","Frequency1","Frequency2","Frequency3","Frequency4","Frequency5","Amplitude1","Amplitude2","Amplitude3","Amplitude4","Amplitude5","Phase1","Phase2","Phase3","Phase4","Phase5","Shift")
d3 <- data.frame(rep("MLCK", 20),1:20,X35)
names(d3) <- c("Type","Id","Frequency1","Frequency2","Frequency3","Frequency4","Frequency5","Amplitude1","Amplitude2","Amplitude3","Amplitude4","Amplitude5","Phase1","Phase2","Phase3","Phase4","Phase5","Shift")
cos5 <- rbind(d1, d2, d3)
matrix <- reshape(cos5, varying=list(c("Frequency1","Frequency2","Frequency3","Frequency4","Frequency5"),
                                     c("Amplitude1","Amplitude2","Amplitude3","Amplitude4","Amplitude5"),
                                     c("Phase1","Phase2","Phase3","Phase4","Phase5")), direction="long", timevar="Id", 
                                     idvar=c("Type","Id"), v.names=c("Frequency", "Amplitude","Phase"))
matrix$Cell <- rep(c(1:20,1:24,1:20),5)
m1 <- matrix[matrix$Type=='Control',]
m2 <- matrix[matrix$Type=='ROCK',]
m3 <- matrix[matrix$Type=='MLCK',]
write.csv(m1,"matrix1.csv", row.names = FALSE)
write.csv(m2,"matrix2.csv", row.names = FALSE)
write.csv(m3,"matrix3.csv", row.names = FALSE)

names(MM1) <- c("Max", "Min")
names(MM2) <- c("Max", "Min")
names(MM3) <- c("Max", "Min")
MM <- rbind(MM1, MM2, MM3)
cos5 <- cbind(cos5, MM)

max_mean <- aggregate(cos5$Max-cos5$Min, list(cos5$Type), mean)
max_se <- aggregate(cos5$Max-cos5$Min, list(cos5$Type), std.error)
max_whisks <- data.frame(c("Control","ROCK","MLCK"), max_mean$x, max_mean$x+2*max_se$x, max_mean$x-2*max_se$x);
names(max_whisks) <- c("V1", "V2", "V3", "V4")
min_mean <- aggregate(cos5$Min, list(cos5$Type), mean)
min_se <- aggregate(cos5$Min, list(cos5$Type), std.error)
min_whisks <- data.frame(c("Control","ROCK","MLCK"), min_mean$x, min_mean$x+2*min_se$x, min_mean$x-2*min_se$x);
names(min_whisks) <- c("V1", "V2", "V3", "V4")

pmax <- ggplot() +
  geom_point(aes(x=cos5$Type, y=(cos5$Max-cos5$Min), color = cos5$Type, color = factor(cos5$Type)), alpha = 0.5) +
  geom_errorbar((aes(x=max_whisks$V1, ymax=max_whisks$V3, ymin=max_whisks$V4, colour=max_whisks$V1)), width = 0.3) +
  geom_point(aes(x=max_whisks$V1, y=max_whisks$V2, colour=max_whisks$V1), size = 3) +
  theme(legend.position = "none") + ylab("Max") + xlab("Type")
pmin <- ggplot() +
  geom_point(aes(x=cos5$Type, y=cos5$Min, color = cos5$Type, color = factor(cos5$Type)), alpha = 0.5) +
  geom_errorbar((aes(x=min_whisks$V1, ymax=min_whisks$V3, ymin=min_whisks$V4, colour=min_whisks$V1)), width = 0.3) +
  geom_point(aes(x=min_whisks$V1, y=min_whisks$V2, colour=min_whisks$V1), size = 3) + ylim(-1.0,3.0) +
  theme(legend.title = element_blank()) + ylab("Min") + xlab("Type")

plot_grid(pmax, pmin,
          labels = c("Max Max", "Min Max"),
          ncol = 2, nrow = 1)
# 
# #Cos 1
# p <- ggplot(cos1, aes(x = Type, y = Frequency, color = Type)) + geom_violin(bw = 'ucv') +
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4)  + ylim(0,3)
# 
# #Cos 2
# p21 <- ggplot(cos2, aes(x = Type, y = Frequency1, color = Type)) + geom_violin(bw = 'ucv') +
#  geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p22 <- ggplot(cos2, aes(x = Type, y = Frequency2, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# #Cos 3
# p31 <- ggplot(cos3, aes(x = Type, y = Frequency1, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p32 <- ggplot(cos3, aes(x = Type, y = Frequency2, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p33 <- ggplot(cos3, aes(x = Type, y = Frequency3, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# #Cos 4
# p41 <- ggplot(cos4, aes(x = Type, y = Frequency1, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p42 <- ggplot(cos4, aes(x = Type, y = Frequency2, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p43 <- ggplot(cos4, aes(x = Type, y = Frequency3, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p44 <- ggplot(cos4, aes(x = Type, y = Frequency4, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# #Cos 5
# p51 <- ggplot(cos5, aes(x = Type, y = Frequency1, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p52 <- ggplot(cos5, aes(x = Type, y = Frequency2, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p53 <- ggplot(cos5, aes(x = Type, y = Frequency3, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p54 <- ggplot(cos5, aes(x = Type, y = Frequency4, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# p55 <- ggplot(cos5, aes(x = Type, y = Frequency5, color = Type)) + geom_violin(bw = 'ucv') + 
#   geom_boxplot(width=0.2) + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.4) + ylim(0,3)
# 
# plot_grid(p,p21,p31, p33, p41, p43, p51, p53,
#           labels = c("Cos1 1", "Cos2 1", "Cos3 1", "Cos3 3","Cos4 1", "Cos4 3","Cos5 1", "Cos5 3"),
#           ncol = 4, nrow = 2)
# 
# library('plotrix')
# cos <- aggregate(cos5[,1:5], list(cos5$Type), mean)
# se <- aggregate(cos5[,1:5], list(cos5$Type), std.error)
# cos <- melt(cos, id=c("Group.1"))
# se <- melt(se, id=c("Group.1"))
# means <- cbind(cos,se[,3])
# means[,4] <- 2*means[,4]
# names(means) <- c("Type","Frequency","Mean","SE")
# means$comb <- interaction(means$Type, means$Frequency)
# ggplot(means, aes(x=comb, y=Mean, colour=Type)) + 
#   geom_errorbar(aes(ymin=(Mean-SE), ymax=(Mean+SE)), width = 0.3) + 
#   geom_point(aes(x=comb, y=Mean, colour=Type)) + 
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))
# 
# library('plotrix')
# err$Comb <- interaction(err$Type, err$Cos)
# cos <- aggregate(err[,1], list(err$Comb), mean)
# se <- aggregate(err[,1], list(err$Comb), std.error)
# means_free <- cbind(cos,se[,2])
# means_free[,3] <- 2*means_free[,3]
# names(means_free) <- c("Type","Mean","SE")
# 
# err$Comb <- interaction(err$Type, err$Cos)
# cos <- aggregate(err[,1], list(err$Comb), mean)
# se <- aggregate(err[,1], list(err$Comb), std.error)
# means <- cbind(cos,se[,2])
# means[,3] <- 2*means[,3]
# names(means) <- c("Type","Mean","SE")
# p1 <- ggplot() + 
#   geom_errorbar((aes(x=means$Type, ymin=(means$Mean-means$SE), ymax=(means$Mean+means$SE), colour=means$Type)), width = 0.3) + 
#   geom_point(aes(x=means$Type, y=means$Mean, colour=means$Type), shape = 0) +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylim(2,20)
# p2 <- ggplot() + 
#   geom_errorbar((aes(x=means_free$Type, ymin=(means_free$Mean-means_free$SE), ymax=(means_free$Mean+means_free$SE), colour=means_free$Type)), width = 0.5) + 
#   geom_point(aes(x=means_free$Type, y=means_free$Mean, colour=means_free$Type)) +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1)) + ylim(2,20)
# plot_grid(p1, p2,
#           labels = c("MSEs Fixed", "MSEs Free"),
#           ncol = 2, nrow = 1)
#           
# 
# file <- paste(path,"/Data/Data13.mat", sep='')
# M <- readMat(file)
# err_free <- M$err
# err <- M$err
# err <- as.data.frame(err)
# 
# err_free <- as.data.frame(err_free)
# err[,6] <- c("Control", "ROCK", "MLCK")
# err <- cbind(err[,6], err[,1:5])
# names(err) <- c("Type","cos1", "cos2", "cos3", "cos4", "cos5")
# err <- melt(err, id=c("Type"))
# 
# err_free[,6] <- c("Control", "ROCK", "MLCK")
# err_free <- cbind(err_free[,6], err_free[,1:5])
# names(err_free) <- c("Type","cos1", "cos2", "cos3", "cos4", "cos5")
# err_free <- melt(err_free, id=c("Type"))
# 
# err <- cbind(err, err_free[,3])
# 
# names(err) <- c("Type","Cos", "MeanFix", "MeanFree")
# err$Comb <- interaction(err$Type, err$Cos)
# ggplot(err) + 
#   geom_point(aes(x=Comb, colour=Type, y = MeanFix), shape = 0) +
#   geom_point(aes(x=Comb, colour=Type, y = MeanFree)) +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1), panel.spacing = unit(0.1, "lines"))
#   #ylim(0.5,8.5)
# 
# d1 <- data.frame(K1, rep("Control", 82))
# names(d1) <- c("Amplitude","Period","Clust","Type")
# d1$Clust[d1$Amplitude > 2] <- 5;
# #d1$Clust[d1$Clust == 8] <- 9; d1$Clust[d1$Clust == 4] <- 10; d1$Clust[d1$Clust == 1] <- 11; d1$Clust[d1$Clust == 5] <- 12; d1$Clust[d1$Clust == 2] <- 13; d1$Clust[d1$Clust == 7] <- 14; d1$Clust[d1$Clust == 6] <- 15; d1$Clust[d1$Clust == 3] <- 16;
# #d1$Clust[d1$Clust == 9] <- 1; d1$Clust[d1$Clust == 10] <- 2; d1$Clust[d1$Clust == 11] <- 3; d1$Clust[d1$Clust == 12] <- 4; d1$Clust[d1$Clust == 13] <- 5; d1$Clust[d1$Clust == 14] <- 6; d1$Clust[d1$Clust == 15] <- 7; d1$Clust[d1$Clust == 16] <- 8;
# d1$Cluster <- interaction(d1$Type, d1$Clust)
# d1$Clust <- as.character(d1$Clust)
# 
# d2 <- data.frame(K2,rep("ROCK", 100))
# names(d2) <- c("Amplitude","Period","Clust","Type")
# d2$Clust[d2$Amplitude > 2.5] <- 5;
# #d2$Clust[d2$Clust == 3] <- 9; d2$Clust[d2$Clust == 7] <- 10; d2$Clust[d2$Clust == 2] <- 11; d2$Clust[d2$Clust == 1] <- 12; d2$Clust[d2$Clust == 6] <- 13; d2$Clust[d2$Clust == 5] <- 14; d2$Clust[d2$Clust == 4] <- 15;
# #d2$Clust[d2$Clust == 9] <- 1; d2$Clust[d2$Clust == 10] <- 2; d2$Clust[d2$Clust == 11] <- 3; d2$Clust[d2$Clust == 12] <- 4; d2$Clust[d2$Clust == 13] <- 5; d2$Clust[d2$Clust == 14] <- 6; d2$Clust[d2$Clust == 15] <- 7;
# d2$Cluster <- interaction(d2$Type, d2$Clust)
# d2$Clust <- as.character(d2$Clust)
# 
# d3 <- data.frame(K3,rep("MLCK", 90))
# names(d3) <- c("Amplitude","Period","Clust","Type")
# d3$Clust[d3$Clust == 3] <- 5; d3$Clust[d3$Clust == 1] <- 6; d3$Clust[d3$Clust == 2] <- 7; 
# d3$Clust[d3$Clust == 5] <- 1; d3$Clust[d3$Clust == 6] <- 2; d3$Clust[d3$Clust == 7] <- 3; 
# #d3$Clust[d3$Clust == 6] <- 9; d3$Clust[d3$Clust == 2] <- 10; d3$Clust[d3$Clust == 5] <- 11; d3$Clust[d3$Clust == 1] <- 12; d3$Clust[d3$Clust == 3] <- 13; d3$Clust[d3$Clust == 4] <- 14;
# #d3$Clust[d3$Clust == 9] <- 1; d3$Clust[d3$Clust == 10] <- 2; d3$Clust[d3$Clust == 11] <- 3; d3$Clust[d3$Clust == 12] <- 4; d3$Clust[d3$Clust == 13] <- 5; d3$Clust[d3$Clust == 14] <- 6;
# d3$Cluster <- interaction(d3$Type, d3$Clust)
# d3$Clust <- as.character(d3$Clust)
# clusters <- rbind(d1, d2, d3)
# #clusters <- clusters[!(clusters$Clust==3 | clusters$Clust==7 | clusters$Clust==8 | clusters$Cluster=='Control.6' | clusters$Cluster=='MLCK.6'),]
# 
# library('plotrix')
# d <- data.frame(aggregate(clusters[,1], list(clusters$Cluster), mean))
# names(d) <- c("Cluster","xmean")
# xse <- aggregate(clusters[,1], list(clusters$Cluster), std.error); d$xse <- 2*xse[,2]
# ymean <- aggregate(clusters[,2], list(clusters$Cluster), mean); d$ymean <- ymean[,2]
# yse <- aggregate(clusters[,2], list(clusters$Cluster), std.error); d$yse <- 2*yse[,2]
# d$type <- c(rep("Control", 5), rep("ROCK", 5), rep("MLCK",4))
# d$clust <- as.character(c(1:5, 1:5, 1:4))
# 
# ggplot() +
#   geom_point(data = clusters, aes(x=Amplitude, y=Period, colour=Type, shape=Clust), alpha = 0.2, size = 3) +
#   geom_errorbar(data = d, aes(x=xmean, colour=type, ymin=(ymean-yse), ymax=(ymean+yse)), width = 0.05) + 
#   geom_errorbarh(data = d, aes(y=ymean, colour=type, xmin=(xmean-xse), xmax=(xmean+xse)), height = 0.5) +
#   geom_point(data = d, aes(x=xmean, y=ymean, colour=type, shape=clust), size = 3) #+ scale_shape_manual(values = c(1:4))
# 
# c1 <- data.frame(2*pi/x15[1:5], x15[6:10], rep("Control",5))
# names(c1) <- c('Period','Amplitude','Type')
# c2 <- data.frame(2*pi/x25[1:5], x25[6:10], rep("ROCK",5))
# names(c2) <- c('Period','Amplitude','Type')
# c3 <- data.frame(2*pi/x35[1:5], x35[6:10], rep("MLCK",5))
# names(c3) <- c('Period','Amplitude','Type')
# 
# library('cowplot')
# p1 <- ggplot() + geom_point(data = d1, aes(x=Amplitude, y=Period, color=Cluster), size = 3) + 
#   geom_point(data = c1, aes(x=Amplitude, y=Period), size = 5, color = 'firebrick') + xlim(0,3.6) + ylim(0,30)
# p2 <- ggplot() + geom_point(data = d2, aes(x=Amplitude, y=Period, color=Cluster), size = 3) + 
#   geom_point(data = c2, aes(x=Amplitude, y=Period), size = 5, color = 'firebrick') + xlim(0,3.6) + ylim(0,30)
# p3 <- ggplot() + geom_point(data = d3, aes(x=Amplitude, y=Period, color=Cluster), size = 3) + 
#   geom_point(data = c3, aes(x=Amplitude, y=Period), size = 5, color = 'firebrick') + xlim(0,3.6) + ylim(0,30)
# plot_grid(p1,p2,p3,
#           labels = c("Control", "ROCK", "MLCK"),
#           ncol = 3, nrow = 1)
# 
# c <- rbind(c1,c2,c3)
# 
# p1 <- ggplot() +  
#   geom_point(data = clusters, aes(x=Amplitude, y=Period, colour=Type), alpha = 0.5, size = 1) +
#   geom_point(data = c, aes(x=Amplitude, y=Period, color=Type), size = 3) + 
#   xlim(0,3.6) + ylim(0,30)
# p2 <- ggplot() +  
#   geom_point(data = clusters, aes(x=Amplitude, y=Period, colour=Type), alpha = 0.5, size = 1) +
#   geom_point(data = c, aes(x=Amplitude, y=Period, color=Type), size = 3) + 
#   xlim(0,0.4) + ylim(0,25)
# plot_grid(p1,p2,
#           labels = c("Individual cells scale", "Tight scale"),
#           ncol = 2, nrow = 1)
# 
d1a <- data.frame(L1,MaxA1); d1m <- data.frame(TF1,MinA1);
d2a <- data.frame(L2,MaxA2); d2m <- data.frame(TF2,MinA2);
d3a <- data.frame(L3,MaxA3); d3m <- data.frame(TF3,MinA3);

t1 <- c(L1,TF1); t2 <- c(L2,TF2); t3 <- c(L3,TF3);
w1 <- c(MaxA1,MinA1); w2 <- c(MaxA2,MinA2); w3 <- c(MaxA3,MinA3);
w1[w1 > 0] <- 1; w2[w2 > 0] <- 1; w3[w3 > 0] <- 1;
w1[w1 < 0] <- -1; w2[w2 < 0] <- -1; w3[w3 < 0] <- -1;

par(mfrow=c(1,3))
weighted.hist(t1, w1, main = 'Control', freq = FALSE)
weighted.hist(t2, w2, main = 'ROCK', freq = FALSE)
weighted.hist(t3, w3, main = 'MLCK', freq = FALSE)

par(mfrow=c(3,2))
hist(MaxA1, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MinA1, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MaxA2, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MinA2, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MaxA3, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MinA3, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)

par(mfrow=c(2,3))
hist(MaxA1, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MaxA2, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MaxA3, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)

hist(MinA1, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MinA2, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)
hist(MinA3, breaks = 5, xlim = c(-1.5,3), ylim = c(0, 1), freq = FALSE)

p1 <- ggplot() +
  geom_histogram(data = d1a, aes(x = MaxA1, y = ..density..), bins = 6, colour="black", color="white") + 
  geom_density(data = d1a, aes(MaxA1), color = 'red', trim = FALSE) + ylim(0,1) # + xlim(-1,3.5)
p2 <- ggplot() +
  geom_histogram(data = d2a, aes(x = MaxA2, y = ..density..), bins = 6, colour="black", color="white") + 
  geom_density(data = d2a, aes(MaxA2), color = 'green', trim = FALSE) + ylim(0,1) # + xlim(-1,3.5)
p3 <- ggplot() +
  geom_histogram(data = d3a, aes(x = MaxA3, y = ..density..), bins = 6, colour="black", color="white") +
  geom_density(data = d3a, aes(MaxA3), color = 'blue', trim = FALSE) + ylim(0,1) # + xlim(-1,3.5)
plot_grid(p1,p2,p3,
          labels = c("Control", "ROCK", "MLCK"),
          ncol = 1, nrow = 3)


p1 <- ggplot() +
  geom_histogram(data = d1m, aes(x = MinA1, y = ..density..), bins = 6, colour="black", color="white") + 
  geom_density(data = d1m, aes(MinA1), color = 'red', trim = FALSE) + ylim(0,1) # + xlim(-1,3.5)
p2 <- ggplot() +
  geom_histogram(data = d2m, aes(x = MinA2, y = ..density..), bins = 6, colour="black", color="white") + 
  geom_density(data = d2m, aes(MinA2), color = 'green', trim = FALSE) + ylim(0,1) # + xlim(-1,3.5)
p3 <- ggplot() +
  geom_histogram(data = d3m, aes(x = MinA3, y = ..density..), bins = 6, colour="black", color="white") +
  geom_density(data = d3m, aes(MinA3), color = 'blue', trim = FALSE) + ylim(0,1) # + xlim(-1,3.5)
plot_grid(p1,p2,p3,
          labels = c("Control", "ROCK", "MLCK"),
          ncol = 1, nrow = 3)


mmax1 <- median(MaxA1); mmin1 <- median(MinA1)
lmax1 <- median(L1); tmin1 <- median(TF1)
mmax2 <- median(MaxA2); mmin2 <- median(MinA2)
lmax2 <- median(L2); tmin2 <- median(TF2)
mmax3 <- median(MaxA3); mmin3 <- median(MinA3)
lmax3 <- median(L3); tmin3 <- median(TF3)

semax1 <- 2*std.error(MaxA1); semin1 <- 2*std.error(MinA1)
selmax1 <- std.error(L1); setmin1 <- std.error(TF1)
semax2 <- 2*std.error(MaxA2); semin2 <- 2*std.error(MinA2)
selmax2 <- std.error(L2); setmin2 <- std.error(TF2)
semax3 <- 2*std.error(MaxA3); semin3 <- 2*std.error(MinA3)
selmax3 <- std.error(L3); setmin3 <- std.error(TF3)

p1 <- ggplot() +
  geom_point(data = d1a, aes(x=L1, y=MaxA1), size = 1, color='red') +
  geom_point(data = d1m, aes(x=TF1, y=MinA1), size = 1, color='blue') +
  ylim(-1.6,3)
p2 <- ggplot() +
  geom_point(data = d2a, aes(x=L2, y=MaxA2), size = 1, color='red') +
  geom_point(data = d2m, aes(x=TF2, y=MinA2), size = 1, color='blue') +
  ylim(-1.6,3)
p3 <- ggplot() +
  geom_point(data = d3a, aes(x=L3, y=MaxA3), size = 1, color='red') +
  geom_point(data = d3m, aes(x=TF3, y=MinA3), size = 1, color='blue') +
  ylim(-1.6,3)
plot_grid(p1,p2,p3,
          labels = c("Control", "ROCK", "MLCK"),
          ncol = 3, nrow = 1)

file <- paste(path,"/Data/Data13.mat", sep='')
M <- readMat(file); MaxA1 <- t(M$MaxA1); MinA1 <- t(M$MinA1)
MaxC1 <- t(M$MaxC1); MinC1 <- t(M$MinC1)
Diff1 <- t(M$Diff1)

file <- paste(path,"/Data/Data23.mat", sep='')
M <- readMat(file); MaxA2 <- t(M$MaxA2); MinA2 <- t(M$MinA2)
MaxC2 <- t(M$MaxC2); MinC2 <- t(M$MinC2)
Diff2 <- t(M$Diff2)

file <- paste(path,"/Data/Data33.mat", sep='')
M <- readMat(file); MaxA3 <- t(M$MaxA3); MinA3 <- t(M$MinA3)
MaxC3 <- t(M$MaxC3); MinC3 <- t(M$MinC3)
Diff3 <- t(M$Diff3)

D1 <- data.frame(Diff1,rep('Control', length(Diff1))); names(D1) <- c('Range','Type')
D2 <- data.frame(Diff2,rep('ROCK', length(Diff2))); names(D2) <- c('Range','Type')
D3 <- data.frame(Diff3,rep('MLCK', length(Diff3))); names(D3) <- c('Range','Type')
Diff <- rbind(D1, D2, D3)

M11 <- data.frame(MaxA1, L1, rep('Control', length(MaxA1)), MaxC1); 
names(M11) <- c('Value','Time','Type','Cell')
M21 <- data.frame(MaxA2, L2, rep('ROCK', length(MaxA2)), MaxC2); 
names(M21) <- c('Value','Time','Type','Cell')
M31 <- data.frame(MaxA3, L3, rep('MLCK', length(MaxA3)), MaxC3); 
names(M31) <- c('Value','Time','Type','Cell')
Max <- rbind(M11,M21,M31)

M12 <- data.frame(MinA1, TF1, rep('Control', length(MinA1)), MinC1); 
names(M12) <- c('Value','Time','Type','Cell')
M22 <- data.frame(MinA2, TF2, rep('ROCK', length(MinA2)), MinC2); 
names(M22) <- c('Value','Time','Type','Cell')
M32 <- data.frame(MinA3, TF3, rep('MLCK', length(MinA3)), MinC3);
names(M32) <- c('Value','Time','Type','Cell')
Min <- rbind(M12,M22,M32)

M <- rbind(M11,M12,M21,M22,M31,M32)

p1 <- ggplot(data = Max, aes(x=Type, y=Value, color=Type)) +
  geom_violin() + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.1) +
  ylim(-2,4)
p2 <- ggplot(data = Min, aes(x=Type, y=Value, color=Type)) +
  geom_violin() + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.1) +
  ylim(-2,4)
plot_grid(p1,p2,
          labels = c("All Max", "All Min"),
          ncol = 2, nrow = 1)

p1 <- ggplot(data = Max[Max$Cell == 'Control',], aes(x=Value)) +
  geom_histogram(aes(y=..density..), color='coral2', fill = 'coral2', alpha = 0.1, position="identity", binwidth = 0.12)  + 
  geom_density(alpha = 0.2, color='coral2', fill = 'coral2') + 
  geom_vline(xintercept = mmax1, color = 'red') + geom_vline(xintercept = mmax1-semax1, linetype="dashed", color = 'red') + 
  geom_vline(xintercept = mmax1+semax1, linetype="dashed", color = 'red') +
  coord_cartesian(xlim = c(-1.7, 3), ylim = c(0, 1.3))  +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.title.x=element_blank(),
        axis.text.y=element_blank(), axis.ticks.y=element_blank(), axis.title.y=element_blank(),
        legend.position = 'top')
p2 <- ggplot(data = Max[Max$Cell == 'ROCK',], aes(x=Value)) +
  geom_histogram(aes(y=..density..), color='palegreen3', fill = 'palegreen3', alpha = 0.1, position="identity", binwidth = 0.12)  + 
  geom_density(alpha = 0.2, color='palegreen3', fill = 'palegreen3') + 
  geom_vline(xintercept = mmax2, color = 'green4') + geom_vline(xintercept = mmax2-semax2, linetype="dashed", color = 'green4') + 
  geom_vline(xintercept = mmax2+semax2, linetype="dashed", color = 'green4') +
  coord_cartesian(xlim = c(-1.7, 3), ylim = c(0, 1.3)) + 
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.title.x=element_blank(),
        axis.text.y=element_blank(), axis.ticks.y=element_blank(), axis.title.y=element_blank())
p3 <- ggplot(data = Max[Max$Cell == 'MLCK',], aes(x=Value)) +
  geom_histogram(aes(y=..density..), color='dodgerblue2', fill = 'dodgerblue2', alpha = 0.1, position="identity", binwidth = 0.12)  + 
  geom_density(alpha = 0.2, color='dodgerblue2', fill = 'dodgerblue2') + 
  geom_vline(xintercept = mmax3, color = 'blue') + geom_vline(xintercept = mmax3-semax3, linetype="dashed", color = 'blue') + 
  geom_vline(xintercept = mmax3+semax3, linetype="dashed", color = 'blue') +
  coord_cartesian(xlim = c(-1.7, 3), ylim = c(0, 1.3)) + 
  theme(axis.text.y=element_blank(), axis.ticks.y=element_blank(), axis.title.y=element_blank())
p4 <- ggplot(data = Min[Min$Cell == 'Control',], aes(x=Value)) +
  geom_histogram(aes(y=..density..), color='coral2', fill = 'coral2', alpha = 0.1, position="identity", binwidth = 0.12)  + 
  geom_density(alpha = 0.2,  color='coral2', fill = 'coral2') + 
  geom_vline(xintercept = mmin1, color = 'red') + geom_vline(xintercept = mmin1-semin1, linetype="dashed", color = 'red') + 
  geom_vline(xintercept = mmin1+semin1, linetype="dashed", color = 'red') +
  coord_cartesian(xlim = c(-1.7, 3), ylim = c(0, 1.3)) + 
  theme(legend.position = "none", axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.title.x=element_blank())
p5 <- ggplot(data = Min[Min$Cell == 'ROCK',], aes(x=Value)) +
  geom_histogram(aes(y=..density..), color='palegreen3', fill = 'palegreen3', alpha = 0.1, position="identity", binwidth = 0.12)  + 
  geom_density(alpha = 0.2,  color='palegreen3', fill = 'palegreen3') + 
  geom_vline(xintercept = mmin2, color = 'green4') + geom_vline(xintercept = mmin2-semin2, linetype="dashed", color = 'green4') + 
  geom_vline(xintercept = mmin2+semin2, linetype="dashed", color = 'green4') +
  coord_cartesian(xlim = c(-1.7, 3), ylim = c(0, 1.3)) + 
  theme(legend.position = "none", axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.title.x=element_blank())
p6 <- ggplot(data = Min[Min$Cell == 'MLCK',], aes(x=Value)) +
  geom_histogram(aes(y=..density..), color='dodgerblue2', fill = 'dodgerblue2', alpha = 0.1, position="identity", binwidth = 0.12)  + 
  geom_density(alpha = 0.2, color='dodgerblue2', fill = 'dodgerblue2') +
  geom_vline(xintercept = mmin3, color = 'blue') + geom_vline(xintercept = mmin3-semin3, linetype="dashed", color = 'blue') + 
  geom_vline(xintercept = mmin3+semin3, linetype="dashed", color = 'blue') +
  coord_cartesian(xlim = c(-1.7, 3), ylim = c(0, 1.3)) + 
  theme(legend.position = "none")
plot_grid(p4,p1,p5,p2,p6,p3,
          labels = c("Control All Min", "Control All Max",
                     "ROCK All Min", "ROCK All Max", 
                     "MLCK All Min", "MLCK All Max"),
          ncol = 2, nrow = 3)


Max$Cell[Max$Cell < 10] <- paste0("0", Max$Cell[Max$Cell < 10])
Min$Cell[Min$Cell < 10] <- paste0("0", Min$Cell[Min$Cell < 10])

Max$Cell <- as.character(Max$Cell)
Min$Cell <- as.character(Min$Cell)

Mat <- rbind(Max,Min)

p1 <- ggplot(data = Mat[Mat$Type == 'Control',], aes(x=Time, fill = Cell, label = Cell, weight = Value)) +
  geom_histogram(color='black', binwidth = 4) +
  stat_bin(binwidth=4, geom="text", colour="black", vjust = 1.5, check_overlap = TRUE)
p1

p2 <- ggplot(data = Max[Max$Type == 'ROCK',], aes(x=Time, fill = Cell, label = Cell, weight = Value)) +
  geom_histogram(color='black', binwidth = 3) +
  stat_bin(binwidth=3, geom="text", colour="black", vjust = 2, check_overlap = TRUE)
p2

p3 <- ggplot(data = Max[Max$Type == 'MLCK',], aes(x=Time, fill = Cell, label = Cell, weight = Value)) +
  geom_histogram(color='black', binwidth = 3) +
  stat_bin(binwidth=3, geom="text", colour="black", vjust = 2, check_overlap = TRUE)
p3

p4 <- ggplot(data = Min[Min$Type == 'Control',], aes(x=Time, fill = Cell, label = Cell, weight = Value)) +
  geom_histogram(color='black', binwidth = 3) +
  stat_bin(binwidth=3, geom="text", colour="black", vjust = 2, check_overlap = TRUE)
p4

p5 <- ggplot(data = Min[Min$Type == 'ROCK',], aes(x=Time, fill = Cell, label = Cell, weight = Value)) +
  geom_histogram(color='black', binwidth = 3) +
  stat_bin(binwidth=3, geom="text", colour="black", vjust = 2, check_overlap = TRUE)
p5

p6 <- ggplot(data = Min[Min$Type == 'MLCK',], aes(x=Time, fill = Cell, label = Cell, weight = Value)) +
  geom_histogram(color='black', binwidth = 3) +
  stat_bin(binwidth=3, geom="text", colour="black", vjust = 2, check_overlap = TRUE)
p6

p1 <- ggplot(data = Max, aes(x=Value, color=Cell, fill = Cell)) +
  geom_density(alpha = 0.2) + xlim(-2,3.5) + ylim(0,0.9) +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.title.x=element_blank())
p2 <- ggplot(data = Min, aes(x=Value, color=Cell, fill = Cell)) +
  geom_density(alpha = 0.2) + xlim(-2,3.5) + ylim(0,0.9)
plot_grid(p1,p2,
          labels = c("All Max", "All Min"),
          ncol = 1, nrow = 2)

group_colors <- c("coral2", "red", "blue", "dodgerblue2", "palegreen3")
p <- ggplot(data = M, aes(x=Type, y=Value)) +
  geom_violin(aes(color = Cell))  +
  geom_point(aes(color = Cell, fill = Cell)) + 
  scale_color_manual(values=group_colors) +
  ylim(-2,3)
p

p <- ggplot(data = M, aes(x=Type, y=Value)) +
  geom_bar(aes(fill = Cell), stat="identity") +
  geom_errorbar(ymin=info$Mean-info$SE_2, ymax=info$Mean+info$SE_2, color = 'black')
p

info_max <- aggregate(Max$Value, list(Max$Type), median)
names(info_max) <- c('Type','Median')
sd <- aggregate(Max$Value, list(Max$Type), std.error)
info_max$CI_95 <- 1.96*sd$x
info_max$CI_90 <- 1.645*sd$x

info_min <- aggregate(Min$Value, list(Min$Type), median)
names(info_min) <- c('Type','Median')
sd <- aggregate(Min$Value, list(Min$Type), std.error)
info_min$CI_95 <- 1.96*sd$x
info_min$CI_90 <- 1.645*sd$x

p1 <- ggplot(data = info_max, aes(x=Type, y = Median)) +
  geom_bar(aes(fill = Type), stat="identity") +
  geom_errorbar(aes(ymin=Median-CI_90, ymax=Median+CI_90), color = 'black', width = 0.2) +
  ylim(-0.2,1.7)
p2 <- ggplot(data = info_min, aes(x=Type, y = Median)) +
  geom_bar(aes(fill = Type), stat="identity") +
  geom_errorbar(aes(ymin=Median-CI_90, ymax=Median+CI_90), color = 'black', width = 0.2) +
  ylim(-0.2,1.7)
plot_grid(p1,p2,
          labels = c("Max 90 CI", "Min 90 CI"),
          ncol = 2, nrow = 1)


info <- aggregate(Diff$Range, list(Diff$Type), mean)
names(info) <- c('Type','Mean')
se <- aggregate(Diff$Range, list(Diff$Type), std.error)
info$CI_95 <- 1.96*se$x
info$CI_90 <- 1.645*se$x

p <- ggplot(data = info, aes(x=Type, y = Mean)) +
  geom_bar(aes(fill = Type), stat="identity") +
  geom_errorbar(aes(ymin=Mean-CI_95, ymax=Mean+CI_95), color = 'black', width = 0.2)
plot_grid(p,
          labels = c("Range 95 CI"),
          ncol = 1, nrow = 1)

p <- ggplot(data = Diff, aes(x=Type, y=Range, color = Type)) +
  geom_violin(bw='ucv')  + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.2, aes(fill=Type))
p

p <- ggplot(data = info, aes(x=Type, y=Mean, fill = Type)) +
  geom_bar(stat="identity") +
  geom_errorbar(aes(ymin = Mean-SE_2, ymax = Mean+SE_2), color = 'black', width = 0.2) + 
  ggtitle("Median +- 2SE")
p

p1 <- ggplot() +
  geom_errorbar(aes(x=lmax1, ymin=(mmax1-semax1), ymax=(mmax1+semax1)), color='red', width = 0.05) +
  geom_errorbar(aes(x=tmin1, ymin=(mmin1-semin1), ymax=(mmin1+semin1)), color='blue', width = 0.05) +
  geom_errorbarh(aes(y=mmax1, xmin=(lmax1-selmax1), xmax=(lmax1+selmax1)), color='red', height = 0.05) +
  geom_errorbarh(aes(y=mmin1, xmin=(tmin1-setmin1), xmax=(tmin1+setmin1)), color='blue', height = 0.05) +
  geom_point(aes(x=lmax1, y=mmax1), size = 3, color='red', shape = 1) +
  geom_point(aes(x=tmin1, y=mmin1), size = 3, color='blue', shape = 1) +
  geom_errorbar(aes(x=lmax2, ymin=(mmax2-semax2), ymax=(mmax2+semax2)), color='red', width = 0.05) +
  geom_errorbar(aes(x=tmin2, ymin=(mmin2-semin2), ymax=(mmin2+semin2)), color='blue', width = 0.05) +
  geom_errorbarh(aes(y=mmax2, xmin=(lmax2-selmax2), xmax=(lmax2+selmax2)), color='red', height = 0.05) +
  geom_errorbarh(aes(y=mmin2, xmin=(tmin2-setmin2), xmax=(tmin2+setmin2)), color='blue', height = 0.05) +
  geom_point(aes(x=lmax2, y=mmax2), size = 3, color='red', shape = 2) +
  geom_point(aes(x=tmin2, y=mmin2), size = 3, color='blue', shape = 2) +
  geom_errorbar(aes(x=lmax3, ymin=(mmax3-semax3), ymax=(mmax3+semax3)), color='red', width = 0.05) +
  geom_errorbar(aes(x=tmin3, ymin=(mmin3-semin3), ymax=(mmin3+semin3)), color='blue', width = 0.05) +
  geom_errorbarh(aes(y=mmax3, xmin=(lmax3-selmax3), xmax=(lmax3+selmax3)), color='red', height = 0.05) +
  geom_errorbarh(aes(y=mmin3, xmin=(tmin3-setmin3), xmax=(tmin3+setmin3)), color='blue', height = 0.05) +
  geom_point(aes(x=lmax3, y=mmax3), size = 3, color='red', shape = 0) +
  geom_point(aes(x=tmin3, y=mmin3), size = 3, color='blue', shape = 0) +
  ylim(-1.6,3)

p2 <- ggplot() +
  geom_boxplot(data = d1a, aes( x = 'Control', y = MaxA1 ), color = 'red') +
  geom_boxplot(data = d2a, aes( x = 'ROCK', y = MaxA2 ), color = 'green') +
  geom_boxplot(data = d3a, aes( x = 'MLCK', y = MaxA3 ), color = 'blue') + ylim(-1.6,3)

p3 <- ggplot() +
  geom_boxplot(data = d1m, aes( x = 'Control', y = MinA1 ), color = 'red') +
  geom_boxplot(data = d2m, aes( x = 'ROCK', y = MinA2 ), color = 'green') +
  geom_boxplot(data = d3m, aes( x = 'MLCK', y = MinA3 ), color = 'blue') + ylim(-1.6,3)
plot_grid(p1,p2,p3,
          labels = c("Means +- 2SE", "Max", "Min"),
          ncol = 3, nrow = 1)


MM_new <- reshape(MM, varying=list(c("Max_max","Max_min","Min_max","Min_min","First_max","First_min","Median_max","Median_min","Mean_max","Mean_min"),
                                   c("TMax_max","TMax_min","TMin_max","TMin_min","TFirst_max","TFirst_min","TMedian_max","TMedian_min","TMean_max","TMean_min")), 
                  direction="long", v.names=c("Value","Time"), 
                  timevar="Group", 
                  times=c("Max_max","Max_min","Min_max","Min_min","First_max","First_min","Median_max","Median_min","Mean_max","Mean_min"))
MM <- MM_new[,1:4]
rownames(MM) <- NULL

d <- data.frame(aggregate(MM$Time, list(MM$Type, MM$Group), mean))
names(d) <- c("Type","Group","Time_Mean")
Time_SE <- aggregate(MM$Time, list(MM$Type, MM$Group), std.error); d$Time_SE <- 2*Time_SE[,3]
Value_Mean <- aggregate(MM$Value, list(MM$Type, MM$Group),mean); d$Value_Mean <- Value_Mean[,3]
Value_SE <- aggregate(MM$Value, list(MM$Type, MM$Group), std.error); d$Value_SE <- 2*Value_SE[,3]

ggplot() +
  geom_point(data = MM, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)

MM_lil <- MM[MM$Group == 'First_max',]; d_lil <- d[d$Group == 'First_max',];
p1 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'First_min',]; d_lil <- d[d$Group == 'First_min',];
p2 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Median_max',]; d_lil <- d[d$Group == 'Median_max',];
p3 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Median_min',]; d_lil <- d[d$Group == 'Median_min',];
p4 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Mean_max',]; d_lil <- d[d$Group == 'Mean_max',];
p5 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Mean_min',]; d_lil <- d[d$Group == 'Mean_min',];
p6 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Max_max',]; d_lil <- d[d$Group == 'Max_max',];
p7 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Max_min',]; d_lil <- d[d$Group == 'Max_min',];
p8 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Min_max',]; d_lil <- d[d$Group == 'Min_max',];
p9 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
MM_lil <- MM[MM$Group == 'Min_min',]; d_lil <- d[d$Group == 'Min_min',];
p10 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) +
  xlim(0,55) + ylim(-1.6,3)
plot_grid(p1,p3,p5,p7,p9, 
          p2,p4,p6,p8,p10,
          labels = c("First Max", "Median Max", "Mean Max", "Max max", "Min Max",
                     "First Min", "Median Min", "Mean Min", "Min Max", "Min Min"),
          ncol = 5, nrow = 2)

MM_lil <- MM[MM$Group == 'First_max',]; d_lil <- d[d$Group == 'First_max',];
p1 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'First_min',]; d_lil <- d[d$Group == 'First_min',];
p2 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Median_max',]; d_lil <- d[d$Group == 'Median_max',];
p3 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Median_min',]; d_lil <- d[d$Group == 'Median_min',];
p4 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Mean_max',]; d_lil <- d[d$Group == 'Mean_max',];
p5 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Mean_min',]; d_lil <- d[d$Group == 'Mean_min',];
p6 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Max_max',]; d_lil <- d[d$Group == 'Max_max',];
p7 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Max_min',]; d_lil <- d[d$Group == 'Max_min',];
p8 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Min_max',]; d_lil <- d[d$Group == 'Min_max',];
p9 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3)
MM_lil <- MM[MM$Group == 'Min_min',]; d_lil <- d[d$Group == 'Min_min',];
p10 <- ggplot() +
  geom_point(data = MM_lil, aes(x = Time, y = Value, color = Type), alpha = 0.5) +
  geom_errorbar(data = d_lil, aes(x=Time_Mean, ymin=(Value_Mean-Value_SE), ymax=(Value_Mean+Value_SE), color = Type), width = 0.5) +
  geom_errorbarh(data = d_lil, aes(y=Value_Mean, xmin=(Time_Mean-Time_SE), xmax=(Time_Mean+Time_SE), color = Type), height = 0.05) +
  geom_point(data = d_lil, aes(x=Time_Mean, y=Value_Mean, colour=Type), size = 3) 
plot_grid(p1,p3,p5,p7,p9, 
          p2,p4,p6,p8,p10,
          labels = c("First Max", "Median Max", "Mean Max", "Max max", "Min Max",
                     "First Min", "Median Min", "Mean Min", "Min Max", "Min Min"),
          ncol = 5, nrow = 2)  
  
  

