# Download input data from the links provided.
# And this CodeBook explains the script in run_analysis.R, in order to produce the final and desired output.

###  Description of script in run_analysis.R
###  ---------------------------------------
    
###### Step 0: Download input data and unzip samsung activity data 
     Downloads Activity data
     Unzips downloaded file

###### Step 1: Merges the training and the test sets to create one data set.
     Read test data
     Read train data
     activity header column data
     features header column data
     Merge row data
     Insert column headers for the read data
     Merge Train, Test and Subject data

###### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

     extract indicies for columns which contains words 'mean' or 'std'
     extract columns of mean & std data 

###### Step 3: Uses descriptive activity names to name the activities in the data set

     Insert column headers in activityh data
     In extractedData, replace activity numbers with activity descriptions

###### Step 4: Appropriately labels the data set with descriptive variable names.

     Replace column names starting with letter 't' with 'Time-'
     Replace column names starting with letter 'f' with 'Frequency-'

###### Step 5: From the data set in step 4, creates a second, independent tidy data set with 
######         the average of each variable for each activity and each subject.

     create dataset 'tidyData' with means on each variable 'activity' and 'subject'
     write dataset 'tidyData' with means on each variable 'activity' and 'subject'

###### Variables Description
     Variables x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from input files.
     variables features, activity and subject merge the previous datasets to further analysis.
     mergedData contains merged dataset
     extractedData contains columns of with description mean & std
     extractedData2 contains extractedData plus activity description 
     tidyData contains final result
