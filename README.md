The run_analysis.R program creates a tidy dataset using the data in the folder "UCI HAR Dataset" expected in the working directory. The UCI HAR folder includes 2 sub folders for Train and Test data, as well as information related to the set in general. 

This is data related to Human Activity Recognition Using Smartphones.
see:   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

The program does the following:

1. Colecting the data into one dataframe
For Test and Train separately, the information from the Subject file(=the human), the Y file(=activity code) and the x file(=measurements) is collected into one DF each, and the 2 are then merged.
It is important to connect all data related to test / train before merging then to avoid potential sorting as part of the merge.

2. Filtering unwanted data
Only variables containing "-mean()" or "-std()" are valid. Measurement labels are obtained from the features file, filtered for the right key word, and used to filter unneeded measurements as well as describe those that are left.

3. Making reading data easier
Expanding on some of the short labels (for example -t for time, f for frequency) for clarity. Also - replacing activity codes with descriptions (walking...)

4. Output
The program creates an "Averaged" tidydata file (that line is a remark at this version as the file was already created and submitted). Tne program does create the detailed tidydata file as a text file. 
 

 
 
  
