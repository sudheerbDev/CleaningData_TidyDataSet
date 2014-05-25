Analysis process for the samsung galaxy human activity dataset
==============================================================

## Assumptions
* Various human activity using samsung galaxy wearable have been conducted 
* Data and the description are in the format as noted in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones as of 5/25/2014

## Pre-requisites
* Human activity data has been downloaded, unzipped and stored in the current working directory with folder name "UCI HAR Dataset"
* R programming language is used to create a tidy dataset and do analysis. Additionally, reshape2 library has been installed and loaded 

## Detailed Analysis Process
* First, all the features and activity labels are loaded independently which applies to both training and test datasets.
* For each of Test and Training dataset, the following operations are performed
	- Data with all features are loaded, associated with columns from features loaded previously.
	- SubjectId associated with a specific observation is also loaded and associated with feature dataset
	- Finally, activity are named appropriately using the activity lables provided.
* Training and Test dataset are combined to a single big dataset.
* For this analysis, we are only concerned about mean and standard deviation values for each of the activity. So, the columns are filtered only with mean and standard deviation values. Rest of the columns from the dataset are ignored.
* For the filtered set of columns, all the columns are made more descriptive and unified.
	- They are all renamed to have lower case
	- "-", "(", ")" characters are eliminated from the column names. 
	- Eg. Original column with name "tBodyAcc-mean()-X" will be made "tbodyaccmeanx"
* Finally, for each of the feature, average for each subject and activity is taken. Since there are 6 activities and 30 subjects, there will be 180 (6 * 30) subgroups generated for each feature filtered above
	

