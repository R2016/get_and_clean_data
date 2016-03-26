# CodeBook
## Study design

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

An R script called `run_analysis.R` was created that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each      activity and each subject.  

## Source data

The raw data used for this project was the Human Acitivity Recognition Using Smartphones Data Set downloaded from the UCI Machine Learning Repository.  The unzipped data (files and directory structure) was not modified.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Source data variables  

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

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in `features.txt`  

Acivities are labeled as follows:  

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

## Summary of `run_analysis.R`

__Set working directory to location of UCI HAR Dataset__

`setwd("~/UCI HAR Dataset")`  

__Read UCI HAR Dataset into R__

1. "./activity_labels.txt"  
2. "./features.txt"  
3. "./test/subject_test.txt"  
4. "./test/X_test.txt"  
5. "./test/y_test.txt"  
6. "./train/subject_train.txt"  
7. "./train/X_train.txt"  
8. "./train/y_train.txt"

__Assign column names__

`colnames( )` function was used.  The observations in `features.txt` were used to label variables in the test data.  

__Merges the training and the test sets to create one data set__  

First, `cbind( )` was used to combine test data (`y_test`, `X_test`) and train data (`X_train`, `y_train`), respectively.  Then the test and training data sets were aggregated using `rbind( )`.  
          
__Extract only the measurements on the mean and standard deviation for each measurement__

`grepl( )` was used to subset only `mean` and `standard deviation` values in the UCI data set.  
NOTE: assumed "meanFreq( )" measurements (13) were not to be included...only "mean( )-"
          
__Uses descriptive activity names to name the activities in the data set__  

A `for ( )` loop was used to cycle through all of the activity observations (int) and replace the integer value with the corresponding label (chr).    

Ex. `activityId` == 1 was replaced with corresponding activity label `"WALKING"`

__Appropriately labels the data set with descriptive variable names__  

First, a character vector of column names in the data set was created.  Then, a `for ( )` loop was used to cycle through the data.  Inside the `for ( )` loop, `gsub( )` was used to find/fix/replace variable names.  

The following changes were made to clean up the original (raw data) varialbe (column) names and assign the replacements. 

*    t to time  
*    Mag to Magnitude  
*    -mean to Mean  
*    Acc to Accel  
*    f to Frequency  
*    -std to StdDev  
*    remove "( )"  
*    BodyBody = Body     

__From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject__  

Installed `reshape2` package to use `melt( )` and `dcast( )` to reshape the data so that we can see variable averages broken down by activity type and subject.   

__Write/export tidy data set__  

Used the `write.table( )` function to export `tidyData.txt` to working directory.  

## Units and Transformations `tidyData.txt`   

Information about the method of capture, units, processing and variable names for the source (raw) UCI HAR Dataset used for this project can be found in the `Source data variables` section above.  

The R script `run_analysis.R` was used to produce the tidy data set `tidyData.txt` from the UCI HAR Dataset by the following, modifying operations:  

1. Assinging column (variable) names [formating]  
2. Introducing column (variable) names [activityId, volunteerId]
3. Merging data sets [aggregation]
4. Extracting only measurements on mean and standard deviation [subsetting]
5. Replacing integer activity obsersations with corresponding descriptive labels (chr)   
6. Modifying original variable names on mean and standard deviation to be more readable/descriptive
7. Calculating the mean of data subset variables  
8. Reshaping data to view variable averages by activity type and subject  

For a more detailed information on modifications to UCI HAR Dataset review `Summary of run_analysis.R` section in this document or `run_analysis.R` script.  

### Variables `tidyData.txt`     

`tidyData.txt` is a tab delimited text file which contains 180 observations of 68 variables:   

  activityId                      : chr   
  volunteerId                     : int  
  TimeBodyAccelMean-X             : num  
  TimeBodyAccelMean-Y             : num    
  TimeBodyAccelMean-Z             : num    
  TimeBodyAccelStdDev-X           : num    
  TimeBodyAccelStdDev-Y           : num    
  TimeBodyAccelStdDev-Z           : num    
  TimeGravityAccelMean-X          : num    
  TimeGravityAccelMean-Y          : num    
  TimeGravityAccelMean-Z          : num    
  TimeGravityAccelStdDev-X        : num    
  TimeGravityAccelStdDev-Y        : num    
  TimeGravityAccelStdDev-Z        : num   
  TimeBodyAccelJerkMean-X         : num  
  TimeBodyAccelJerkMean-Y         : num  
  TimeBodyAccelJerkMean-Z         : num  
  TimeBodyAccelJerkStdDev-X       : num  
  TimeBodyAccelJerkStdDev-Y       : num  
  TimeBodyAccelJerkStdDev-Z       : num  
  TimeBodyGyroMean-X              : num  
  TimeBodyGyroMean-Y              : num  
  TimeBodyGyroMean-Z              : num  
  TimeBodyGyroStdDev-X            : num  
  TimeBodyGyroStdDev-Y            : num  
  TimeBodyGyroStdDev-Z            : num  
  TimeBodyGyroJerkMean-X          : num  
  TimeBodyGyroJerkMean-Y          : num  
  TimeBodyGyroJerkMean-Z          : num  
  TimeBodyGyroJerkStdDev-X        : num  
  TimeBodyGyroJerkStdDev-Y        : num  
  TimeBodyGyroJerkStdDev-Z        : num  
  TimeBodyAccelMagnitudeMean      : num  
  TimeBodyAccelMagnitudeStdDev    : num  
  TimeGravityAccelMagnitudeMean   : num  
  TimeGravityAccelMagnitudeStdDev : num  
  TimeBodyAccelJerkMagnitudeMean  : num  
  TimeBodyAccelJerkMagnitudeStdDev: num  
  TimeBodyGyroMagnitudeMean       : num  
  TimeBodyGyroMagnitudeStdDev     : num  
  TimeBodyGyroJerkMagnitudeMean   : num  
  TimeBodyGyroJerkMagnitudeStdDev : num  
  FreqBodyAccelMean-X             : num  
  FreqBodyAccelMean-Y             : num  
  FreqBodyAccelMean-Z             : num  
  FreqBodyAccelStdDev-X           : num  
  FreqBodyAccelStdDev-Y           : num  
  FreqBodyAccelStdDev-Z           : num  
  FreqBodyAccelJerkMean-X         : num  
  FreqBodyAccelJerkMean-Y         : num  
  FreqBodyAccelJerkMean-Z         : num  
  FreqBodyAccelJerkStdDev-X       : num  
  FreqBodyAccelJerkStdDev-Y       : num  
  FreqBodyAccelJerkStdDev-Z       : num  
  FreqBodyGyroMean-X              : num  
  FreqBodyGyroMean-Y              : num  
  FreqBodyGyroMean-Z              : num  
  FreqBodyGyroStdDev-X            : num  
  FreqBodyGyroStdDev-Y            : num  
  FreqBodyGyroStdDev-Z            : num  
  FreqBodyAccelMagnitudeMean      : num  
  FreqBodyAccelMagnitudeStdDev    : num  
  FreqBodyAccelJerkMagnitudeMean  : num  
  FreqBodyAccelJerkMagnitudeStdDev: num  
  FreqBodyGyroMagnitudeMean       : num  
  FreqBodyGyroMagnitudeStdDev     : num  
  FreqBodyGyroJerkMagnitudeMean   : num  
  FreqBodyGyroJerkMagnitudeStdDev : num    

