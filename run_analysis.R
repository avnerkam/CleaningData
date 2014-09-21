#install.packages("reshape")
#install.packages("dplyr")
library(dplyr)

### COLLECTING DATA
### reading relevant files from *working directory* where folder "UCI HAR Dataset" is placed
### first - column-binding "Subject", "Activity", "X-values", separately for "test" and "train"
x_test = read.table('UCI HAR Dataset/test/X_test.txt', header = FALSE)
x_train = read.table('UCI HAR Dataset/train/X_train.txt', header = FALSE)
y_test = read.table('UCI HAR Dataset/test/y_test.txt', header = FALSE)
y_train = read.table('UCI HAR Dataset/train/y_train.txt', header = FALSE)
subject_test = read.table('UCI HAR Dataset/test/subject_test.txt', header = FALSE)
subject_train = read.table('UCI HAR Dataset/train/subject_train.txt', header = FALSE)
data_test<-cbind(subject_test, y_test, x_test)
data_train<-cbind(subject_train, y_train, x_train)
### then - bind "test" and "train" to make "Data"
data<-rbind(data_test, data_train)

### EXTRACTING MEAN/STD VARIABLES
### My undertanding is that only variables including "mean()" or "Std()" qualify
### first - starting with the features file and flagging variables to continue with
features = read.table('UCI HAR Dataset/features.txt', header = FALSE, stringsAsFactors= FALSE)
names(features)<-c("seq", "feature")
### creating a new column to flag desired features
features<-mutate(features, valid=(grepl("-mean\\()", feature)|(grepl("-std\\()", feature)) ))
### then - naming the variables of "data" for easy column filtering
features <-rbind(c(0,"subject", "TRUE"), c(0, "activity", "TRUE"), features)
names(data)<-as.vector(features$feature)
### and now - removing unwanted feature names and filtering the right columns into tidydata
filterednames<-features$feature[features$valid==TRUE]
tidydata<-data[, filterednames]

### MAKING FOR EASIER READING
### here I expand on some labels and convert activity code to clear terms
### I do it step-by-step as global substitutions can be unpredictable
### I am conservative expanding on terms as long labels can be an issue
x<-names(tidydata)
x<-sub("tBody", "timeBody", x)
x<-sub("tGravity", "timeGravity", x) 
x<-sub("fBody", "freqBody", x)
x<-sub("fGravity", "freqGravity", x)
x<-gsub("()", "", x, fixed=TRUE)
x<-gsub("Acc", "Accel", x)
names(tidydata)<-x
### now changing values of "Activity" based on my short-version of labels-file
actlabels<-c("walking", "walking up", "walking down", "sitting", "standing", "laying")
tidydata$activity<-actlabels[as.numeric(tidydata$activity)] 

### AVERAGING
### summarizing the data to create tidydata_averaged
### note I did not change variable names to reflect average, but the file is named as such
tidydata_grouped<-group_by(tidydata, subject, activity) 
tidydata_averaged<-summarise_each(tidydata_grouped, funs(mean))

### OUTPUT
###now, writing out to files
write.table(tidydata, file="tidydata.txt", row.name=FALSE)
#write.table(tidydata_averaged, file="tidydata_averaged.txt", row.name=FALSE)
  
