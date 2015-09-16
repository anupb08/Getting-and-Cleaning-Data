library(plyr)
#unzip("getdata_Dataset.zip")
dir <- getwd()
uci_path <- paste(dir,"UCI\ HAR\ Dataset", sep="/")
setwd(uci_path) # set current working directory to "UCI HAR Dataset"

#load dataset
xtraindata   = read.table("./train/X_train.txt",header=FALSE) #imports x_train.txt
ytraindata   = read.table("./train/y_train.txt",header=FALSE) #imports y_train.txt
activitylebel = read.table("./activity_labels.txt",header=FALSE) #imports activity_labels.txt
features = read.table("./features.txt",header=FALSE) 
subjecttrain = read.table("./train/subject_train.txt",header=FALSE) 
subjecttest  = read.table("./test/subject_test.txt",header=FALSE) 
xtestdata    = read.table("./test/X_test.txt",header=FALSE) 
ytestdata    = read.table("./test/y_test.txt",header=FALSE) 

# 1. Merges the training and the test sets to create one data set.
xdata <- rbind(xtraindata, xtestdata)
ydata <- rbind(ytraindata, ytestdata) # merging activity type
subjectdata <- rbind(subjecttrain, subjecttest)  # merging subject data

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features_mean_std <- grep("-(mean|std).*\\(" , features[,2])  # extract row numbers with mean and standard deviation measurements from feature
featurenames <- features[features_mean_std,][,2]  
xdata <- xdata[, features_mean_std] # select columns with mean and standard deviation
colnames(xdata) <- as.character(featurenames) # Apply columns name 

# 3. Uses descriptive activity names to name the activities in the data set

ydata[,1] <- activitylebel[ydata[,1], 2]   # naming activity label ,eg. replace 1 by WALKING , 2 by WALKING_UPSTAIRS 
colnames(ydata) <- "activity"   # set column name
colnames(subjectdata) <- "subject"

# create a single dataset by merge all datasets  
finaldata <- cbind( subjectdata,ydata, xdata)


# 4. Appropriately labels the data set with descriptive variable names. 
featurenames <- gsub("-mean", "Mean", featurenames)
featurenames <- gsub("-std", "StdDev", featurenames)
featurenames <- gsub("\\()", "", featurenames)
featurenames <- gsub("-", "", featurenames)
featurenames <- gsub("Acc", "Accelerator", featurenames)
featurenames <- gsub("Mag", "Magnitude", featurenames)
featurenames <- gsub("Gyro", "Gyroscope", featurenames)
featurenames <- gsub("^t", "time", featurenames)
featurenames <- gsub("^f", "frequency", featurenames)
featurenames <- c("subject", "activity", featurenames)
colnames(finaldata) <- featurenames  #apply descriptive variables name

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
setwd(dir)
mymean <- function(x){
ln <- length(x)
  colMeans(x[,3:ln])
 }

tidydata <- ddply(finaldata,.(activity,subject),  mymean) # create tidy dataset
write.table(finaldata, file = "./tidydata.txt", row.name=FALSE)  # write tidy data to tidydata.txt file
