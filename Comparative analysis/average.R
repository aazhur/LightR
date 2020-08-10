library('R.matlab')
library('ggplot2')
library('plotrix')
library('cowplot')
library('diptest')
library('EnvStats')
library('GMCM')
library('colorRamps')

path <- getwd()
file <- paste(path,"/Velocities.mat", sep='')
M <- readMat(file)

Control <- M$Control
ROCK <- M$ROCK
MLCK <- M$MLCK

Control_stat <- data.frame(colMeans(Control),GMCM:::colSds(Control), 1:56, rep('Control',56))
names(Control_stat) <- c('Mean','SD','Time','Type')
Control_stat$SE <- Control_stat$SD*1.645/sqrt(20)
Control_stat$SE95 <- Control_stat$SD*1.960/sqrt(20)

ROCK_stat <- data.frame(colMeans(ROCK),GMCM:::colSds(ROCK), 1:56, rep('ROCK',56))
names(ROCK_stat) <- c('Mean','SD','Time','Type')
ROCK_stat$SE <- ROCK_stat$SD*1.645/sqrt(24)
ROCK_stat$SE95 <- ROCK_stat$SD*1.960/sqrt(24)

MLCK_stat <- data.frame(colMeans(MLCK),GMCM:::colSds(MLCK), 1:56, rep('MLCK',56))
names(MLCK_stat) <- c('Mean','SD','Time','Type')
MLCK_stat$SE <- MLCK_stat$SD*1.645/sqrt(20)
MLCK_stat$SE95 <- MLCK_stat$SD*1.960/sqrt(20)

Stat <- rbind(Control_stat,ROCK_stat,MLCK_stat)

p1 <- ggplot(data = Control_stat) +
  geom_ribbon(aes(ymin=Mean-SE, ymax=Mean+SE, x = Time), fill="red", alpha="0.4") +
  geom_line(aes(x=Time, y=Mean)) + geom_point(aes(x=Time, y=Mean)) + ylim(-0.5,2.1) + theme_linedraw()

p2 <- ggplot(data = ROCK_stat) + 
  geom_ribbon(aes(ymin=Mean-SE, ymax=Mean+SE, x = Time), fill="green", alpha="0.4") +
  geom_line(aes(x=Time, y=Mean)) + geom_point(aes(x=Time, y=Mean)) + ylim(-0.5,2.1) + theme_linedraw()

p3 <- ggplot(data = MLCK_stat) + 
  geom_ribbon(aes(ymin=Mean-SE, ymax=Mean+SE, x = Time), fill="blue", alpha="0.4") +
  geom_line(aes(x=Time, y=Mean)) + geom_point(aes(x=Time, y=Mean)) + ylim(-0.5,2.1) + theme_linedraw()

p4 <- ggplot(data = Control_stat) +
  geom_ribbon(aes(ymin=Mean-SE95, ymax=Mean+SE95, x = Time), fill="red", alpha="0.4") +
  geom_line(aes(x=Time, y=Mean)) + geom_point(aes(x=Time, y=Mean)) + ylim(-0.5,2.1) + theme_linedraw()

p5 <- ggplot(data = ROCK_stat) + 
  geom_ribbon(aes(ymin=Mean-SE95, ymax=Mean+SE95, x = Time), fill="green", alpha="0.4") +
  geom_line(aes(x=Time, y=Mean)) + geom_point(aes(x=Time, y=Mean)) + ylim(-0.5,2.1) + theme_linedraw()

p6 <- ggplot(data = MLCK_stat) + 
  geom_ribbon(aes(ymin=Mean-SE95, ymax=Mean+SE95, x = Time), fill="blue", alpha="0.4") +
  geom_line(aes(x=Time, y=Mean)) + geom_point(aes(x=Time, y=Mean)) + ylim(-0.5,2.1) + theme_linedraw()

# p4 <- ggplot(Control_stat, aes(x = Time, y = Type, fill = Mean)) + geom_tile(height = 1) +
#    scale_fill_gradientn(colours = matlab.like2(100), limits =  c(-0.1,1.3)) 
#  
# p5 <- ggplot(ROCK_stat, aes(x = Time, y = Type, fill = Mean)) + geom_tile(height = 1) +   
#   scale_fill_gradientn(colours = matlab.like2(100), limits =  c(-0.1,1.3)) 
# 
# p6 <- ggplot(MLCK_stat, aes(x = Time, y = Type, fill = Mean)) + geom_tile(height = 1) +
#    scale_fill_gradientn(colours = matlab.like2(100), limits =  c(-0.1,1.3)) 

plot_grid(p1,p2,p3,p4,p5,p6,
          labels = c('Control 90% CI','ROCK 90% CI','MLCK 90% CI','Control 95% CI','ROCK 95% CI','MLCK 95% CI'),
          ncol = 3, nrow = 2)

V1 <- data.frame(Control_stat$Mean, Control_stat$Type)
names(V1) <- c('Mean', 'Type')
V2 <- data.frame(ROCK_stat$Mean, ROCK_stat$Type)
names(V2) <- c('Mean', 'Type')
V3 <- data.frame(MLCK_stat$Mean, MLCK_stat$Type)
names(V3) <- c('Mean', 'Type')
V <- rbind(V1, V2, V3)

info <- aggregate(V$Mean, list(V$Type), mean)
names(info) <- c('Type','Mean')
sd <- aggregate(V$Mean, list(V$Type), std.error)
info$CI_95 <- 1.96*sd$x
info$CI_90 <- 1.645*sd$x

p1 <- ggplot(data = info, aes(x=Type, y = Mean)) +
  geom_bar(aes(fill = Type), stat="identity") +
  geom_errorbar(aes(ymin=Mean-CI_95, ymax=Mean+CI_95), color = 'black', width = 0.2)
plot_grid(p1,
          labels = c("Average Velocity 95 CI"),
          ncol = 1, nrow = 1)

Control_mean <- mean(M$Control)
ROCK_mean <- mean(M$ROCK)
MLCK_mean <- mean(M$MLCK)
mean_all <- rbind(Control_mean, ROCK_mean, MLCK_mean)
rownames(mean_all) <- c()

Control_se <- std.error(as.vector(M$Control))
ROCK_se <- std.error(as.vector(M$ROCK))
MLCK_se <- std.error(as.vector(M$MLCK))
se_all <- rbind(Control_se, ROCK_se, MLCK_se)
rownames(se_all) <- c()

info <- data.frame(cbind(mean_all, se_all))
names(info) <- c('Mean','SE')
info$Type <- c('Control','ROCK','MLCK')
info$CI_95 <- 1.96*info$SE
info$CI_90 <- 1.645*info$SE
info$Type <- factor(info$Type, info$Type)

p1 <- ggplot(data = info, aes(x=Type, y = Mean)) +
  geom_bar(aes(fill = Type), stat="identity") +
  geom_errorbar(aes(ymin=Mean-CI_95, ymax=Mean+CI_95), color = 'black', width = 0.2)
plot_grid(p1,
          labels = c("Average Velocity 95 CI"),
          ncol = 1, nrow = 1)
