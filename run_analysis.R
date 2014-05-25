

## This is the primary function to be invoked to create a tidy dataset from the raw samsung wearable data
## unzipped data should be saved under "UCI HAR Dataset" folder
## Tidy Datasets will be saved in the .txt file with headers.
runAnalysis <- function()
{
    # Perform step 1 & 3 - load, merge training and test datasets. 
    ## Also assign labels for activity, associate subjectid
    mergedData <- mergeTrainingAndTestDatasets()
    
    ## step 2 - Extract columns which have mean or standard deviation
    dataWithMeanOrStd <- extractMeanAndStandardDeviationColumns(mergeData)
    
    ## step 4 - Make columns descriptive
    dataWithMeanOrStd <- makeDescriptiveColumnNames(dataWithMeanOrStd)
    
    ## step 5 - Get average for each variable group by activity and subjectid
    avgData <- createGroupedAvgValues(dataWithMeanOrStd)
    
    ## save tidy dataset to local filesystem
    saveDataToLocalFileSystem(avgData)
    
    ## Return the tidy dataset as well.
    avgData
}

## Loads and merges training and test datasets
## Associates subjectId and activity labels
mergeTrainingAndTestDatasets <- function()
{
    ## Read all the available features from features.txt and name the columns
    features <- read.table(file="UCI HAR Dataset/features.txt",
                           col.names = c("featureId", "featureName"))
    
    featureNames <- features[,"featureName"]
    
    ## Read activity labels from activity_labels.txt file and names the columns appropriately
    activityLabels <- read.table(file = "UCI HAR Dataset/activity_labels.txt",
                                 col.names = c("activityId","activityName"))
    
    ## Prepare Training and Test DataSet for merging
    trainingData <- prepareTrainingDatasetForMerge(featureNames, activityLabels)
    testData <- prepareTestDatasetForMerge(featureNames, activityLabels)
    
    ## Merge training and test data using rbing function
    mergedData <- rbind(trainingData, testData)
    
    ## return merged data
    mergedData
}

## Prepares training dataset to merge with test dataset
## Takes featurenames and activity labels as input and returns training data as output data.frame
prepareTrainingDatasetForMerge <- function(featureNames, activityLabes)
{
    # fetch X_train.txt data and set the column names
    trainXData <- read.table(file="UCI HAR Dataset/train/X_train.txt",col.names=featureNames)
    
    # fetch y_train.txt data and set the column names
    trainYData <- read.table(file="UCI HAR Dataset/train/y_train.txt",col.names=c("activityId"))
    
    # Read all the subject data
    trainSubjectData <- read.table(file="UCI HAR Dataset/train/subject_train.txt",col.names=c("subjectId"))
    
    # Join ActivityId's with Activity Labels
    trainYDataWithLabels <- join(trainYData,activityLabels)
    
    # Add ActivityNames, SubjectId and DataSetType columns to training dataset
    trainXData$activity <- trainYDataWithLabels[,"activityName"]
    trainXData$subjectId <- trainSubjectData[,"subjectId"]
    
    trainXData
}

## prepares test dataset to merge with training dataset
## Takes featurenames and activity labels as input and returns test data as output data.frame
prepareTestDatasetForMerge <- function(featureNames, activityLabes)
{
    # fetch X_test.txt data and set the column names
    testXData <- read.table(file="UCI HAR Dataset/test/X_test.txt",col.names=featureNames)
    
    # fetch y_test.txt data and set the column names
    testYData <- read.table(file="UCI HAR Dataset/test/y_test.txt",col.names=c("activityId"))
    
    # Read all the subject data
    testSubjectData <- read.table(file="UCI HAR Dataset/test/subject_test.txt",col.names=c("subjectId"))
    
    # Join ActivityId's with Activity Labels
    testYDataWithLabels <- join(testYData,activityLabels)
    
    # Add ActivityNames, SubjectId and DataSetType columns to training dataset
    testXData$activity <- testYDataWithLabels[,"activityName"]
    testXData$subjectId <- testSubjectData[,"subjectId"]
    
    testXData
}

## Extract the columns which have either mean or standard deviation values from the merged data.
extractMeanAndStandardDeviationColumns <- function(mergedData)
{
    ## Create a pattern that filters columns that has "mean", "std" in their names
    ## Also take activity and subjectId columns
    columnsWithMeanOrStd <- grep(pattern="*mean*|*std*|activity|subjectId",colnames(mergedData))
    
    ## Take data from the filterd columns
    dataWithMeanOrStd <- mergedData[,columnsWithMeanOrStd]
    
    dataWithMeanOrStd
}

## Makes descriptive columns for the merged data - to have a unified standard naming convention
makeDescriptiveColumnNames <- function(dataWithMeanOrStd)
{
    ## Remove characters : -() from the column names
    colnames(dataWithMeanOrStd) <- gsub(pattern="-|)|\\(",replacement="",colnames(dataWithMeanOrStd))

    ## convert all column names to lower case
    colnames(dataWithMeanOrStd) <- tolower(colnames(dataWithMeanOrStd))
    
    dataWithMeanOrStd
}

## creates average values for all variables grouped by activity and subjectId
createGroupedAvgValues <- function(dataWithMeanOrStd)
{
    ## convert from wide range columns to long format based on activity and subjectid
    meltData <- melt(data=dataWithMeanOrStd,id.vars= c("activity","subjectid"))
    
    ## convert all the values to numeric
    meltData$value <- as.numeric(meltData$value)
    
    ## convert back to wide range columns - aggregating using mean for the group (group based of activity and subjectid)
    avgData <- dcast(meltData, activity + subjectid  ~ variable,fun.aggregate=mean)
    
    avgData
}

## saves the tidy dataset to local filesystem
saveDataToLocalFileSystem <- function(avgData)
{
    ## save data to local file
    write.table(avgData, file="avgWithMeanOrStdGroupByActivityAndSubject.txt")
    
    message("A tidy dataset with average of the observations (for Mean and Standar deviation) 
            grouped by ActivityId and SubjectId saved in avgWithMeanOrStdGroupByActivityAndSubject.txt")
}
