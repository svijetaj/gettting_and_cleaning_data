getwd()
setwd("C:/coursera/datascience/uci_data_set")

# library
library(plyr)

#get the data from training set
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#get the data from test set
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

#merge all the related datasets like x,y and subject data
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)


#feature measurement data

features <- read.table("features.txt")

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
head(mean_and_std_features,10)

#subset the desired columns
x_data <- x_data[, mean_and_std_features]
#give names to the columns
names(x_data) <- features[mean_and_std_features,2]

#make the meaningful acitivity labels

activities <- read.table("activity_labels.txt")
head(activities,10)
# update values with correct activity names

y_data[, 1] <- activities[y_data[, 1], 2]

names(y_data)<- "activity"

#name the colum for subject data
head(subject_data,10)

names(subject_data) <- "subject"

#merge all the data to single data

all_data <- cbind(x_data,y_data,subject_data)

#calculate average from the data set

averages <- ddply(all_data,.(subject,activity),function(x) colMeans(x[,1:66]))
head(averages,10)

write.table(averages, "averages_data.txt", row.name=FALSE)
