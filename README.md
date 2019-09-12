This script:

	1. reads all mean and stddev values from both test and train data sets found in UCI HAR data, 
	2. standardizes the variable names to be applied to the data, 
	2. joins both training and test data samples in a single data set, 
	3. outputs a second data set with the average of each variables by subject and activity.

Script Requirements:

	- a "UCI HAR Data" folder in the working directory, 
	  containing the original folder structure and datasets (as unzipped from source file) in the working directory.
	- dplyr package
	- data.table package

The code is split in to 3 main blocks:

	block 1 - prepares the variables' metadata
		a) read the activity labels into memory
		b) reads the variable names into memory
		c) identifies the variables to be read out of the data sets
		d) standardizes the variable names (all lower, no special chars)
		
	block 2 - reads the data sets
		the same approach is used for both training and test data sets:
		a) read data from file (only mean and stdev variables)
		b) read subjects and activities (+ append activity descritions)
		c) cbind all 3 sets into final one: subject + activity + variables
		
	block 3 - assembling the final data set and agregated summary 
		a) as the data in training and test data is complementary (subject are either train or test, never both) a simple rbindind both data sets will do the job
		b) simple aggregation to build the data average summary
	
	
In between blocks I'm cleaning up non required variables.
	
	
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

