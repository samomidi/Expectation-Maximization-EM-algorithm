# Data wrangling
# -----------------------------------------------------------------------
unknown.fish <- x[is.na(x$Age),]


fish <- x[!is.na(x$Age),]
fish$Age <- factor(fish$Age)

# -----------------------------------------------------------------------
#Age vs Length (internal use)
library(ggplot2)
qplot(fish$Age,fish$Length, xlab = "Age", ylab = "Length",
      shape = fish$Age, col = fish$Age) +
  scale_shape_manual(values = 1:3 ) +
  labs(shape = "Fish Ages", col = "colors")

## -----------------------------------------------------------------------
# Red points are mean as box plot does not show mean
ggplot(fish, aes(x=Age, y=Length, fill = Age)) +
  geom_boxplot(alpha = 0.7) +
  stat_summary(fun.y=mean, colour="darkred", geom="point", 
               shape=18, size=3,show_guide = FALSE) +
  scale_y_continuous(name = "Length") + 
  scale_x_discrete(name = "Age") + 
  ggtitle(" Box plot of Age Vs Length") +
  theme_bw() +
  theme(plot.title = element_text(size = 14, family = "Tahoma", face = "bold"),
        text = element_text(size = 12, family = "Tahoma"),
        axis.title = element_text(face="bold"),
        axis.text.x=element_text(size = 11),
        legend.position = "bottom") +
  scale_fill_brewer(palette = "Accent") +
  labs(fill = "Fish Age") +
  geom_jitter()



#--------------------------------------------------------
# Proportional color histogram
# library
library(ggplot2)
ggplot(fish, aes(x=fish$Length)) + 
  geom_histogram(binwidth = 5, aes(fill = ..count..) ) +
  ggtitle("Histogram of length Vs Frequency") +
  theme(plot.title = element_text(size = 14, family = "Tahoma", face = "bold"),
        text = element_text(size = 12, family = "Tahoma"),
        axis.title = element_text(face="bold"),
        axis.text.x=element_text(size = 11),
        legend.position = "bottom") +
  scale_y_continuous(name = "Frequency") + 
  scale_x_continuous(breaks = seq(0,90,5), name = "Length") +
  labs(fill = "Frequency")


#--------------------------------------------------------
# Fish Age Density
ggplot(fish, aes(x=fish$Length, fill=fish$Age)) + geom_density(alpha=.7) +
  scale_y_continuous(name = "Frequency") + 
  scale_x_discrete(name = "Length") +
  ggtitle("Fish density categorised by Age Group") +
  labs(fill = "Fish Age") 


#------------------------------------------
# Histogram of 100 fish density to for internal use
ggplot(fish, aes(x=fish$Length)) + 
  geom_histogram(binwidth = 5, aes(fill = ..count..) ) +
  ggtitle("Histogram of length Vs Frequency") +
  theme(plot.title = element_text(size = 14, family = "Tahoma", face = "bold"),
        text = element_text(size = 12, family = "Tahoma"),
        axis.title = element_text(face="bold"),
        axis.text.x=element_text(size = 11),
        legend.position = "bottom") +
  scale_y_continuous(name = "Frequency") + 
  scale_x_continuous(breaks = seq(0,90,5), name = "Length") +
  labs(fill = "Frequency")



# Histogram of 1000 length Vs PD of estimates

library(plyr)
hist(x$Length, prob = TRUE, col = "green", xlab = "1000 Fish Length", 
     main = "Density Vs Estimated Parameters",
     pch = 16,
     breaks = 20,
     lwd = 2)
lines(density(final.line,adjust = 2), col = "red", lwd= 3)
abline(v = c(23.11276,41.80995,66.86052), lty= 2)
text(x = 23.11276 - 6, y = 0.025, labels = "23.11276")
text(x = 41.80995 - 8, y = 0.025, labels = "41.80995")
text(x = 66.86052 - 6, y = 0.025, labels = "66.86052")
legend("topright", legend = c("Mean", "Estimate"),
       lty = c(2,1),
       col = c(1,2),
       lwd = c(2,2))
line <- rnorm(20000, 23.11276,3.852887)
line2 <- rnorm(800,41.80995,5.629796)
line3 <- rnorm(500,66.86052,8.356849)
temp <- append(line,line2)
final.line <- append(temp,line3)


# Correlation test and Prediction
fish.num <- x[!is.na(x$Age),]
cor(fish.num$Length,fish.num$Age)

lmfish <- lm(Age ~ Length, data = fish)
predData <- data.frame(Length = 45)
predict(lmfish, newdata = predData)