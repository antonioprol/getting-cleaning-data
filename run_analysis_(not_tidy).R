setwd("./getting-cleaning-data")  # wd for the 'Getting and Cleaning Data' Course Project
library(dplyr)
dpathbase <- "UCI HAR Dataset/"
dpathtest <- paste0(dpathbase, "test/")
dpathtrain <- paste0(dpathbase, "train/")

activities <- tbl_df(read.table(paste0(dpathbase, "activity_labels.txt"), col.names= c("id", "activity")))
features <- tbl_df(read.table(paste0(dpathbase, "features.txt"), col.names= c("ind", "names")))
test_labels <- tbl_df(read.table(paste0(dpathtest, "y_test.txt"), col.names= "id"))
train_labels <- tbl_df(read.table(paste0(dpathtrain, "y_train.txt"), col.names= "id"))
subject_test <- tbl_df(read.table(paste0(dpathtest, "subject_test.txt"), col.names= "subject_id"))
subject_train <- tbl_df(read.table(paste0(dpathtrain, "subject_train.txt"), col.names= "subject_id"))
testset <- tbl_df(read.table(paste0(dpathtest, "X_test.txt"), col.names=features$names, colClasses = "numeric"))
trainset <- tbl_df(read.table(paste0(dpathtrain, "X_train.txt"), col.names=features$names, colClasses = "numeric"))
data0 <- tbl_df(rbind(cbind(subject_test, test_labels, testset), cbind(subject_train, train_labels, trainset)))
data <- tbl_df(merge(activities, data0, by.x="id", by.y="id"))  %>% select(-id)

# I select all features with 'mean' or 'std' in their names with either upper or lower case
data_S <- select(data, subject_id, activity, matches("mean|std"))  # 'matches(x, ignore.case = TRUE)' by default
# Final
data_s_g <- data_S %>% group_by(activity, subject_id) %>% summarize_each(funs(mean)) %>% print


# Podemos comprobar que los 2 scripts dan los mismos resultados
filter(data_s_g, activity=="WALKING" & subject_id==2)     # en 'run_analysis_(not_tidy).R'
filter(dataMelt_g, activity=="WALKING" & subject_id==2)   # en 'run_analysis.R'





##
data_s_g <- data_S %>% group_by(activity) %>% group_by(subject_id, add=TRUE) %>% summarize_each(funs(mean)) %>% print
sel_check <- sel_data %>% group_by(subject_id) %>% summarize(length(activity)) %>% print



sel_meas <- grep(pattern="[Mm]ean|[Ss]td", x=features$names, value=TRUE)

nsubject_test <- unique(subject_test)
nsubject_train <- unique(subject_train)


