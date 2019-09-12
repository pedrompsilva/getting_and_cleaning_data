1. the code

	The code is split in to 3 main blocks:

		block 1 - prepares the variables' metadata
			a) read the activity labels into memory
			b) reads the variable names into memory
			c) identifies the variables to be read out of the data sets by usingn regexp masks to select mean() or dev()
			d) standardizes the variable names (all lower, removes special chars)
			
		block 2 - reads the data sets
			The same approach is used for both training and test data sets:
			a) read data from file using fread (reading only mean and stdev variables - the rest is not required)
			b) read subjects and activities (+ append activity descritions)
			c) cbind all 3 sets into final one: subject + activity + variables
			
		block 3 - assembling the final data set and agregated summary 
			a) as the data in training and test data is complementary (subject are either train or test, never both) a simple rbindind both data sets does the job
			b) a simple aggregation to build the data average summary
		
		
	In between blocks I'm cleaning up non required variables using rm().
		
		
	The following variables are used:

		Common Variables (used to label both train and test datasets)
		-----------------------------------------------------------------------------------------------
		labels		data.frame		is am activity lookup table used to translate the activity IDs
		features	data.frame		contains the original list of variables
		varIndex	vector(numeric)		contains the position of the variables to be extracted from the data sets
		varNames	vector(factor)		contains the names of the variables to be aplied to the data sets

		handling train datasets
		-----------------------------------------------------------------------------------------------
		testData	data.frame		contains the selected variables (means+stddev)
		testSubjects	data.frame		contains the test subject identification for each observation
		testActivities	data.frame		contains the activities related with each observation


		handling test datasets
		-----------------------------------------------------------------------------------------------
		trainData	data.frame		contains the selected variables (means+stddev)
		trainSubjects	data.frame		contains the test subject identification for each observation
		trainActivities	data.frame		contains the activities related with each observation

		full 
		-----------------------------------------------------------------------------------------------
		finalDataSet	data.frame		this table contains all observations found in both train and test data sets
		summaryDataSet	data.frame		this table contains the average value for each variable, by subject and activity




2. the output data

	The data is sourced from in both train and test data sets on the original "UCI HAR Data" provided for this assignement.
	The table below, lists the categories and variables output by the script and provides a mapping to the original variables names 
	and respective positions in the data sets.


	Column	Variable			Original_Column	Original_Variable
	1		subject	N/A	
	2		activity	N/A	
	3		tbodyaccmeanx		1				tBodyAcc-mean()-X
	4		tbodyaccmeany		2				tBodyAcc-mean()-Y
	5		tbodyaccmeanz		3				tBodyAcc-mean()-Z
	6		tbodyaccstdx		4				tBodyAcc-std()-X
	7		tbodyaccstdy		5				tBodyAcc-std()-Y
	8		tbodyaccstdz		6				tBodyAcc-std()-Z
	9		tgravityaccmeanx	41				tGravityAcc-mean()-X
	10		tgravityaccmeany	42				tGravityAcc-mean()-Y
	11		tgravityaccmeanz	43				tGravityAcc-mean()-Z
	12		tgravityaccstdx		44				tGravityAcc-std()-X
	13		tgravityaccstdy		45				tGravityAcc-std()-Y
	14		tgravityaccstdz		46				tGravityAcc-std()-Z
	15		tbodyaccjerkmeanx	81				tBodyAccJerk-mean()-X
	16		tbodyaccjerkmeany	82				tBodyAccJerk-mean()-Y
	17		tbodyaccjerkmeanz	83				tBodyAccJerk-mean()-Z
	18		tbodyaccjerkstdx	84				tBodyAccJerk-std()-X
	19		tbodyaccjerkstdy	85				tBodyAccJerk-std()-Y
	20		tbodyaccjerkstdz	86				tBodyAccJerk-std()-Z
	21		tbodygyromeanx		121				tBodyGyro-mean()-X
	22		tbodygyromeany		122				tBodyGyro-mean()-Y
	23		tbodygyromeanz		123				tBodyGyro-mean()-Z
	24		tbodygyrostdx		124				tBodyGyro-std()-X
	25		tbodygyrostdy		125				tBodyGyro-std()-Y
	26		tbodygyrostdz		126				tBodyGyro-std()-Z
	27		tbodygyrojerkmeanx	161				tBodyGyroJerk-mean()-X
	28		tbodygyrojerkmeany	162				tBodyGyroJerk-mean()-Y
	29		tbodygyrojerkmeanz	163				tBodyGyroJerk-mean()-Z
	30		tbodygyrojerkstdx	164				tBodyGyroJerk-std()-X
	31		tbodygyrojerkstdy	165				tBodyGyroJerk-std()-Y
	32		tbodygyrojerkstdz	166				tBodyGyroJerk-std()-Z
	33		fbodyaccmeanx		266				fBodyAcc-mean()-X
	34		fbodyaccmeany		267				fBodyAcc-mean()-Y
	35		fbodyaccmeanz		268				fBodyAcc-mean()-Z
	36		fbodyaccstdx		269				fBodyAcc-std()-X
	37		fbodyaccstdy		270				fBodyAcc-std()-Y
	38		fbodyaccstdz		271				fBodyAcc-std()-Z
	39		fbodyaccjerkmeanx	345				fBodyAccJerk-mean()-X
	40		fbodyaccjerkmeany	346				fBodyAccJerk-mean()-Y
	41		fbodyaccjerkmeanz	347				fBodyAccJerk-mean()-Z
	42		fbodyaccjerkstdx	348				fBodyAccJerk-std()-X
	43		fbodyaccjerkstdy	349				fBodyAccJerk-std()-Y
	44		fbodyaccjerkstdz	350				fBodyAccJerk-std()-Z
	45		fbodygyromeanx		424				fBodyGyro-mean()-X
	46		fbodygyromeany		425				fBodyGyro-mean()-Y
	47		fbodygyromeanz		426				fBodyGyro-mean()-Z
	48		fbodygyrostdx		427				fBodyGyro-std()-X
	49		fbodygyrostdy		428				fBodyGyro-std()-Y
	50		fbodygyrostdz		429				fBodyGyro-std()-Z
