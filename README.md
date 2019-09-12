*The script run_analysis.R:*

	1. reads all mean and stddev values from both test and train data sets found in UCI HAR data, 
	2. standardizes the variable names to be applied to the data, 
	2. joins both training and test data samples in a single data set, 
	3. outputs a second data set with the average of each variables by subject and activity.

*Script Requirements:*

	- the "UCI HAR Data" folder must be present in the working directory, 
	  containing the original folder structure and datasets (as unzipped from source file) in the working directory.
	- dplyr package
	- data.table package
