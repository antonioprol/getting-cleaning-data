## Course Project: Getting and Cleaning Data
This is the repository for the 'Getting and Cleaning Data' Course Project

Student: antonioprol

## 'run_analysis.R'

Script with the R-code necessary to obtain the final data set from the downloaded raw files

Read 'codebook.txt' for more details.

Steps:

### 1. Reading the necessary files and loading into objects

Adding to "testset" ("X_test.txt") and "trainset" ("X_train.txt") descriptive names for the features columns.

### 2.1 Adding the subject id and the activity id to the 'test' and the 'train' datasets

1. cbind() columns "subject_test" ("subject_test.txt") and "test_labels" ("y_test.txt") to "testset" ("X_test.txt")
2. cbind() columns "subject_train" ("subject_train.txt") and "train_labels" ("y_train.txt") to "trainset" ("X_train.txt")

At first "testset" and "trainset" have dimensions 2,947 × 561 and 7,352 × 561, respectively.

Plus 2 columns would be --> 2,947 × 563 and 7,352 × 563, respectively.

### 2.2 ... and clipping the 'test' and 'train' datasets together + adding descriptive activity names

1. rbind() 'test' and 'train' datasets
2. merge() with activity names and select out unwanted id column

At this point we get a data frame (data) with dimensions: 10,299 × 563

### 3.1 Selecting all features with 'mean' or 'std' in their names, with either upper or lower case

Using matches("mean|std")  -  ‘matches(x, ignore.case = TRUE)’ by default

dim(data_s):  10,299 × 88

### 3.2 ... and melting all the 'features' columns to obtain a tidy data set (dataMelt)

dim(dataMelt): 885,714 × 4

### 4. Obtaining the final tidy dataset (tidydata) with the average of each variable for each activity and each subject

dim(tidydata): 15,480 x 4
