total_acc_z_train <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", quote="\"", comment.char="")
View(total_acc_z_train)
total_acc_y_train <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", quote="\"", comment.char="")
View(total_acc_y_train)
y_train <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
View(y_train)
X_train <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
View(X_train)
subject_train <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
View(subject_train)
y_test <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
View(y_test)
X_test <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
View(X_test)
subject_test <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
View(subject_test)

## Merges the training and the test sets to create one data set.
X_total <- rbind(X_train, X_test)
Y_total <- rbind(y_train, y_test)
Sub_total <- rbind(subject_train, subject_test)

## Extracts only the measurements on the mean and standard deviation for each measurement.
variable.names <- read.table("~/Desktop/Coursera/Getting and Cleaning Data Week 1/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
View(variable.names)
selected_var <- variable.names[grep("mean\\(\\)|std\\(\\)",variable.names[,2]),]
X_total <- X_total[,selected_var[,1]]

## Uses descriptive activity names to name the activities in the data set
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y_total[,-1]

## Appropriately labels the data set with descriptive variable names.
colnames(X_total) <- variable.names[selected_var[,1],2]

## From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(Sub_total) <- "subject"
total <- cbind(X_total, activitylabel, Sub_total)
total_mean <- total %>%
    group_by(activitylabel, subject) %>%
    summarize_each(funs(mean))
write.table(total_mean, "tidyData.txt" , row.names = FALSE, col.names = TRUE)