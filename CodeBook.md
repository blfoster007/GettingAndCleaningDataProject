Information on the source data
==============================

The source data was provided by Coursera as part of the assignment and comes from:
Human Activity Recognition Using Smartphones Dataset, Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

You may refer to the following site to understand the data in greater depth:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The solution provided used the following information from the data set:

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

Feature Selection (excerpted from the original data set) 
========================================================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The subset of variables that were used from these signals were: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

The complete list of variables of each feature vector is available in 'features.txt' contained with the original data set.


High Level Summary of Steps Involved for Solution
=================================================

1. Merged the test data set and the data set labels (joined by row number/name and not by a key). Order of data is important.
2. After merge, renamed two column names: OrigRowIndex (column index 1) and ActivityNumber (column index 2).
3. Filtered test data to columns of interest.
4. Ordered resulting test data set by original row index and reset system row index.  Merge (previous activity) will often change the desired order of the data.
5. Merged the test data set with subject numbers (joined by row number/name and not by a key). Order of data is important.
6. After merge, renamed one column name: Subject (column index 2).
7. Deleted resulting new column: Row.names.
8. Merged the training data set and the data set labels (joined by row number/name and not by a key). Order of data is important.
9. After merge, renamed two column names: OrigRowIndex (column index 1) and ActivityNumber (column index 2).
10. Filtered training data to columns of interest.
11. Ordered resulting training data set by original row index and reset system row index.  Merge (previous activity) will often change the desired order of the data.
12. Merged the training data set with subject numbers (joined by row number/name and not by a key). Order of data is important.
13. After merge, renamed one column name: Subject (column index 2).
14. Deleted resulting new column: Row.names (column index 1).
15. Combined test and training data sets (no key was used, columns were in designated order).
16. Merged larger combined data set with activity labels (joined by activity number key).
17. After merge, renamed column name: Activity (column index 2).
18. Deleted resulting new column: V1 (column index 1).
19. Created the tidy set by using the "aggregate" function for the mean and grouping by activity and subject.
20. Cleaned up column names so that they are easier to work with (see below for list of column names and how derived).
21. Created resulting tidy data set file "TidyDataset.txt".  It is is tab delimited with row names set to FALSE.


Cleanup of Resulting Column Names
=================================

Column names were cleaned/transformed with the following logic:
1. "()" and "-" were replaced with blanks ("")
2. "std" was replaced with "Std"
3. "mean" was replaced with "Mean"

The pattern follows the below examples:

"tBodyGyroJerk-mean()-X" becomes "tBodyGyroJerkMeanX"
"tBodyGyroJerk-std()-X" becomes "tBodyGyroJerkStdX"





