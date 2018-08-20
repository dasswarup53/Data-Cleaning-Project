library(plyr)
setwd("/home/swarupdas/data_science/UCI HAR Dataset/")
#merging test and train into one data set
x_train<-read.table("train/X_train.txt")
#class(x_train)
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
# The x data set
x_data <- rbind(x_train, x_test)
# The y data set
y_data <- rbind(y_train, y_test)
# the suject data set
subject_data <- rbind(subject_train, subject_test)
head(x_data)
#extracting mean and std from features
features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
#creating dataset with required columns
x_data <- x_data[, mean_and_std_features]
#renaming columns
names(x_data) <- features[mean_and_std_features, 2]
#renaming labels
activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"
#subject renaming
names(subject_data) <- "subject"
#combining to clean full set
all_data <- cbind(x_data, y_data, subject_data)
#second data set
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)
