The R script described in this document is called 
run_analysis.R.

There is also a CodeBook.md file which has the specific description of the tidy data file contents.

The zip file containing raw data was downloaded and unzipped into the R working directory. The source data is  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 
In the submission box, as well as the link, put some accompanying text on another line something like "tidy data as per the ReadMe that can be read into R with read.table"

Per the ReadMe.txt document in the above zip file, the files X_train.txt and X_test.txt are the measurements files and are mutually exclusive (they do not include data on the same subjects).  The files Y_train.txt and Y_test.txt include the activity being evaluated for the measurements.  The files subject_test.txt and subject_train.txt contains the subject (person) ID.  

The subject ID and activity code were added to the test / train measurement files and column names were added for all values.  

The compiled test and train files were "row joined" since they contain the same data but on different subjects.

Assumption:  Each subject has measurements for all six activities.  No code has been added to handle this situation specifically.

See the CodeBook.md for details on which measurements were retained for the tidy data file and for a description on how their variable names were changed to make them easier to read.  Only fields with "mean" and "std" were kept for the tidy data file.  These columns were selected by manual inspection and column locations noted for use in subsetting the data.

Another column was added to the end of the file which is a descriptive activity being evaluated (instead of just the 1, 2, 3, etc.codes).  The descriptive labels used are found in the activity_labels.txt file as follows:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
This descriptive activity column is called "activity" and is found in column 2.  The field containing activity code 1  - 6 was removed from the file as it did not add value since the more descriptive value is available.

Finally the mean of each measurement variable by subject and activity was determined.  The final tidy data file is written to a text file (tidyDataSet.txt) that meets the principles of Hadley Wickham's paper http://vita.had.co.nz/papers/tidy-data.pdf.  Specifically, 

1. Each variable forms a column.  In this file each measurement is in a separate column.

2. Each observation forms a row.  In this file there is one row for each subject / activity pair.

3. Each type of observational unit forms a table. Only meaursements for the subject / activity pairs are included in this file. 

This file can be read into R using read.table().

