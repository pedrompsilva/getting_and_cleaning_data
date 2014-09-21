
This script:
	1. reads the UCI HAR data
	2. joins both training and test data samples
	3. averages the values of mean and stdev metrics by subject and activity

Requirements:
The script requires:
	- a "UCI HAR Data" folder in the working directory, containing the original folder structure and datasets (as unzipped from source file) in the working directory.
	- dplyr package
	- data.table package

The code is simple: 
	starts by loading all the common files
	loading and tidying train dataset
	loading and tidying test dataset
	merges train and test data
	filters out all non-required variables (columns)
	performs aggregation of the data.
	
in between stages the non-used tables are cleaned up.
	
	
The following variables are used:

		Common Variables (used to label both train and test datasets)
		-----------------------------------------------------------------------------------------------
		colHeaders 		contains a table with the measurements names, to be used as column headers
		activities 		contains a lookup table with the user friendly label for each one of the activities


		handling train datasets
		-----------------------------------------------------------------------------------------------
		trainSubject	the list of subjects performing the activities
		trainX 		 	measurement data samples of each subject's activities
		trainY		 	the activities performed by each subject
		trainDS			this is the final, merged and labelled training dataset.
						field list: Subject, ActivityID, [561 columns with all measurements]

		handling test datasets
		-----------------------------------------------------------------------------------------------
		testSubject		the list of subjects performing the activities
		testX 		 	measurement data samples of each subject's activities
		testY		 	the activities performed by each subject
		testDS			this is the final, merged and labelled test dataset.
						field list: Subject, ActivityID, [561 columns with all measurements]

		full 
		-----------------------------------------------------------------------------------------------
		totalDS			this table contains both train and test all data samples for all metrics of type MEAN or AVG and
						all subject and activities 


		group_subject_activity	is a group used to aggregate data by subject and activity
		agg						defines the aggregation to be applied to totalDS 
		agg_subject_activity 	the resulting data aggregation table
		