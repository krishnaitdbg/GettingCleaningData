This CodeBook explains the script in run_analysis.R

###### Step 0: Download and unzip samsung activity data 

    # Downloads Activity data
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url,destfile='./actdata.zip',methdon='curl')

    # Unzips downloaded file
unzip(zipfile='./actdata.zip',exdir='./')

###### Step 1: Merges the training and the test sets to create one data set.

    #Read test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

    #Read train data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

    #activity header column data
activityh <- read.table("./UCI HAR Dataset/activity_labels.txt")

    #features header column data
featuresh <- read.table("./UCI HAR Dataset/features.txt")

    #Merge row data
subject <- rbind(subject_train, subject_test)
activity <- rbind(y_train, y_test)
features <- rbind(x_train, x_test)

    #Insert column headers for the read data
colnames(subject) <- "subject"
colnames(activity) <- "activity"
colnames(features) <- t(featuresh[2]) 

    #Merge Train, Test and Subject data
mergedData <- cbind(features, activity, subject)
    

###### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

    #extract indicies for columns which contains words 'mean' or 'std'
mean_std_cols <- grep(".*mean.*|.*std.*", names(mergedData), ignore.case=TRUE)

    #extract columns of mean & std data 
extractedData <- cbind(mergedData[,mean_std_cols], mergedData[562:563])

###### Step 3: Uses descriptive activity names to name the activities in the data set

    #Insert column headers in activityh data
colnames(activityh) <- c('activity','activity_desc')

    #In extractedData, replace activity numbers with activity descriptions
extractedData2 <- merge(extractedData, activityh, by='activity', all.x=TRUE)

###### Step 4: Appropriately labels the data set with descriptive variable names.

    #Replace column names starting with letter 't' with 'Time-'
names(extractedData2) <- gsub("^t", "Time-", names(extractedData2))

    #Replace column names starting with letter 'f' with 'Frequency-'
names(extractedData2) <- gsub("^f", "Frequency-", names(extractedData2))

###### Step 5: From the data set in step 4, creates a second, independent tidy data set with 
######         the average of each variable for each activity and each subject.

    #create dataset 'tidyData' with means on each variable 'activity' and 'subject'
tidyData <- aggregate(. ~ subject + activity, extractedData2, mean)
tidyData <- tidyData[order(tidyData$subject, tidyData$activity),]

    #write dataset 'tidyData' with means on each variable 'activity' and 'subject'
write.table(tidyData, "tidyData.txt", row.name=FALSE)