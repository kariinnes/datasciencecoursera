The measurements used for "mean" and "std" per value in features.txt are listed below.  The leading number shows the column in the original file - when subsetting the merged file we added 2 columns to the beginning of the file (Subject ID and Activity ID).  So where subsetting the data, add 2 to each column number shown below.

These fields were selected by manual inspection.  Columns with "meanFreq" and "gravityMean" were not included.

1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
41 tGravityAcc-mean()-X
42 tGravityAcc-mean()-Y
43 tGravityAcc-mean()-Z
44 tGravityAcc-std()-X
45 tGravityAcc-std()-Y
46 tGravityAcc-std()-Z
81 tBodyAccJerk-mean()-X
82 tBodyAccJerk-mean()-Y
83 tBodyAccJerk-mean()-Z
84 tBodyAccJerk-std()-X
85 tBodyAccJerk-std()-Y
86 tBodyAccJerk-std()-Z
121 tBodyGyro-mean()-X
122 tBodyGyro-mean()-Y
123 tBodyGyro-mean()-Z
124 tBodyGyro-std()-X
125 tBodyGyro-std()-Y
126 tBodyGyro-std()-Z
161 tBodyGyroJerk-mean()-X
162 tBodyGyroJerk-mean()-Y
163 tBodyGyroJerk-mean()-Z
164 tBodyGyroJerk-std()-X
165 tBodyGyroJerk-std()-Y
166 tBodyGyroJerk-std()-Z
201 tBodyAccMag-mean()
202 tBodyAccMag-std()
214 tGravityAccMag-mean()
215 tGravityAccMag-std()
227 tBodyAccJerkMag-mean()
228 tBodyAccJerkMag-std()
240 tBodyGyroMag-mean()
241 tBodyGyroMag-std()
253 tBodyGyroJerkMag-mean()
254 tBodyGyroJerkMag-std()
266 fBodyAcc-mean()-X
267 fBodyAcc-mean()-Y
268 fBodyAcc-mean()-Z
269 fBodyAcc-std()-X
270 fBodyAcc-std()-Y
271 fBodyAcc-std()-Z
345 fBodyAccJerk-mean()-X
346 fBodyAccJerk-mean()-Y
347 fBodyAccJerk-mean()-Z
348 fBodyAccJerk-std()-X
349 fBodyAccJerk-std()-Y
350 fBodyAccJerk-std()-Z
424 fBodyGyro-mean()-X
425 fBodyGyro-mean()-Y
426 fBodyGyro-mean()-Z
427 fBodyGyro-std()-X
428 fBodyGyro-std()-Y
429 fBodyGyro-std()-Z
503 fBodyAccMag-mean()
504 fBodyAccMag-std()
516 fBodyBodyAccJerkMag-mean()
517 fBodyBodyAccJerkMag-std()
529 fBodyBodyGyroMag-mean()
530 fBodyBodyGyroMag-std()
542 fBodyBodyGyroJerkMag-mean()
543 fBodyBodyGyroJerkMag-std()

The names were revised to make them more readable.  Specifically these changes were made:

 ----  removed special characters, 
 ----  removed leading "f" and "t",
 ----  changed hyphen to an underscore to separate words 

For example, 

"tBodyAcc-mean()-X" became "BodyAcc_mean_X"
"fBodyBodyGyroMag-std()" became "BodyBodyGyroMag_std"

Fields in the final tidy data set (subjectActivityMean) are:
 [1] "subject_ID"              
 [2] "activity"                
 [3] "BodyAcc_mean_X"          
 [4] "BodyAcc_mean_Y"          
 [5] "BodyAcc_mean_Z"          
 [6] "BodyAcc_sd_X"            
 [7] "BodyAcc_sd_Y"            
 [8] "BodyAcc_sd_Z"            
 [9] "GraviyAcc_mean_X"        
[10] "GraviyAcc_mean_Y"        
[11] "GraviyAcc_mean_Z"        
[12] "GraviyAcc_sd_X"          
[13] "GraviyAcc_sd_Y"          
[14] "GraviyAcc_sd_Z"          
[15] "BodyAccJerk_mean_X"      
[16] "BodyAccJerk_mean_Y"      
[17] "BodyAccJerk_mean_Z"      
[18] "BodyAccJerk_sd_X"        
[19] "BodyAccJerk_sd_Y"        
[20] "BodyAccJerk_sd_Z"        
[21] "BodyGyro_mean_X"         
[22] "BodyGyro_mean_Y"         
[23] "BodyGyro_mean_Z"         
[24] "BodyGyro_sd_X"           
[25] "BodyGyro_sd_Y"           
[26] "BodyGyro_sd_Z"           
[27] "BodyGyroJerk_mean_X"     
[28] "BodyGyroJerk_mean_Y"     
[29] "BodyGyroJerk_mean_Z"     
[30] "BodyGyroJerk_sd_X"       
[31] "BodyGyroJerk_sd_Y"       
[32] "BodyGyroJerk_sd_Z"       
[33] "BodyAccMag_mean"         
[34] "BodyAccMag_sd"           
[35] "GraviyAccMag_mean"       
[36] "GraviyAccMag_sd"         
[37] "BodyAccJerkMag_mean"     
[38] "BodyAccJerkMag_sd"       
[39] "BodyGyroMag_mean"        
[40] "BodyGyroMag_sd"          
[41] "BodyGyroJerkMag_mean"    
[42] "BodyGyroJerkMag_sd"      
[43] "BodyAcc_mean_X.1"        
[44] "BodyAcc_mean_Y.1"        
[45] "BodyAcc_mean_Z.1"        
[46] "BodyAcc_sd_X.1"          
[47] "BodyAcc_sd_Y.1"          
[48] "BodyAcc_sd_Z.1"          
[49] "BodyAccJerk_mean_X.1"    
[50] "BodyAccJerk_mean_Y.1"    
[51] "BodyAccJerk_mean_Z.1"    
[52] "BodyAccJerk_sd_X.1"      
[53] "BodyAccJerk_sd_Y.1"      
[54] "BodyAccJerk_sd_Z.1"      
[55] "BodyGyro_mean_X.1"       
[56] "BodyGyro_mean_Y.1"       
[57] "BodyGyro_mean_Z.1"       
[58] "BodyGyro_sd_X.1"         
[59] "BodyGyro_sd_Y.1"         
[60] "BodyGyro_sd_Z.1"         
[61] "BodyAccMag_mean.1"       
[62] "BodyAccMag_sd.1"         
[63] "BodyBodyAccJerkMag_mean" 
[64] "BodyBodyAccJerkMag_sd"   
[65] "BodyBodyGyroMag_mean"    
[66] "BodyBodyGyroMag_sd"      
[67] "BodyBodyGyroJerkMag_mean"
[68] "BodyBodyGyroJerkMag_sd" 




