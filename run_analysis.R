library(dplyr)
library(reshape2)
dpathbase <- "UCI HAR Dataset/"
dpathtest <- paste0(dpathbase, "test/")
dpathtrain <- paste0(dpathbase, "train/")

# Reading the necessary files and loading into objects
activities <- tbl_df(read.table(paste0(dpathbase, "activity_labels.txt"), col.names= c("id", "activity")))
features <- tbl_df(read.table(paste0(dpathbase, "features.txt"), col.names= c("ind", "names")))
test_labels <- tbl_df(read.table(paste0(dpathtest, "y_test.txt"), col.names= "act_id"))
train_labels <- tbl_df(read.table(paste0(dpathtrain, "y_train.txt"), col.names= "act_id"))
subject_test <- tbl_df(read.table(paste0(dpathtest, "subject_test.txt"), col.names= "subject_id"))
subject_train <- tbl_df(read.table(paste0(dpathtrain, "subject_train.txt"), col.names= "subject_id"))
testset <- tbl_df(read.table(paste0(dpathtest, "X_test.txt"), col.names=features$names, colClasses = "numeric"))
trainset <- tbl_df(read.table(paste0(dpathtrain, "X_train.txt"), col.names=features$names, colClasses = "numeric"))

# Clipping the 'test' and 'train' datasets together
data0 <- tbl_df(rbind(cbind(subject_test, test_labels, testset), cbind(subject_train, train_labels, trainset)))
data <- tbl_df(merge(activities, data0, by.x="id", by.y="act_id"))  %>% select(-id)

# Selecting all features with 'mean' or 'std' in their names, with either upper or lower case
data_s <- select(data, activity, subject_id, matches("mean|std"))  # 'matches(x, ignore.case = TRUE)' by default

# 'dataMelt' is tidy
mvars <- names(data_s)[!(names(data_s) %in% c("activity", "subject_id"))]  # all the column names except 'activity' and 'subject_id'
dataMelt <- tbl_df(melt(data_s, id=c("activity", "subject_id"), measure.vars=mvars))

# Final tidy dataset
tidydata <- dataMelt %>% group_by(activity, subject_id, variable) %>% summarize(mean=mean(value))
write.table(tidydata, file = "tidydata.txt", row.names=FALSE)
