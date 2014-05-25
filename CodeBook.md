CodeBook for the tidy dataset generated from samsung galaxy human activity dataset
==================================================================================

* Please see README.md for description of the analysis process involved in generating a tidy dataset from raw samsung galaxy human activity dataset

## Description of the tidy dataset

Tidy dataset contains the average for each of the mean and standard deviation values generated for each of the features - grouped by human activity and subject

* activity - describes the activity for the observation (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* subjectid - identity of the subject for the observation

variables with pattern below denote the average for each of the signals 
'xyz' is used to denote 3-axial signals in the X, Y and Z directions.

tbodyacc
tgravityacc
tbodyAccjerk
tbodygyro
tbodygyrojerk
tbodyaccmag
tgravityaccmag
tbodyaccjerkmag
tbodygyromag
tbodygyrojerkmag
fbodyacc
fbodyaccjerk
fbodygyro
fbodyaccmag
fbodyaccjerkmag
fbodygyromag
fbodygyrojerkmag

aggregation performed for each of the variable are denoted with following pattern:

mean : Mean value
std : Standard deviation value

