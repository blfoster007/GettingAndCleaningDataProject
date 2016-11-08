# setwd("C:/Users/Testuser1/Documents")

# Load the test dataset
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

# Load feature labels (column names), clean up label data, and convert to vector
FeatureLabels <- read.table("UCI HAR Dataset/features.txt")
FeatureLabels$V1 <- NULL
FeatureLabels <- as.vector(FeatureLabels$V2)

#Set test data column names (feature labels)
names(X_test) <- FeatureLabels

#Load the test dataset labels (for the rows)
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

#Merge the test row labels with the test dataset
XY_test <- merge(Y_test,X_test,by=0)

#Release memory for storage variables
X_test <- NULL
Y_test <- NULL

#Change datset column names to something more descriptive
colnames(XY_test)[1] <- "OrigRowIndex"
colnames(XY_test)[2] <- "ActivityNumber"

#Filter dataset to only columns of interest
XY_test <- XY_test[,grep("^OrigRowIndex$|^ActivityNumber$|[Mm]ean|[Ss]td",colnames(XY_test))]

#Reorder data by original index and reset row names/numbers
#This is necessary since following joins occur by row number and previous
#merge activity reordered data
XY_test <- XY_test[order(as.numeric(XY_test$OrigRowIndex)),]
rownames(XY_test) <- NULL

#Delete column in dataset that is no longer necessary
XY_test$OrigRowIndex <- NULL

#Load the subject numbers dataset and merge with the appropriate rows in the dataset
SubjectNumbers_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
XY_test <- merge(SubjectNumbers_test,XY_test,by=0)

#Release memory for storage variables
SubjectNumbers_test <- NULL

#Change datset column name to something more descriptive
colnames(XY_test)[2] <- "Subject"

#Delete column in dataset that is not necessary
XY_test$Row.names <- NULL

# Load the training dataset
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

#Set test data column names (feature labels), then release memory for storage variable
names(X_train) <- FeatureLabels
FeatureLabels <- NULL

#Load the training dataset labels (for the rows)
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

#Merge the test row labels with the test dataset
XY_train <- merge(Y_train,X_train,by=0)

#Release memory for storage variables
X_train <- NULL
Y_train <- NULL

#Change datset column names to something more descriptive
colnames(XY_train)[1] <- "OrigRowIndex"
colnames(XY_train)[2] <- "ActivityNumber"

#Filter dataset to only columns of interest
XY_train <- XY_train[,grep("^OrigRowIndex$|^ActivityNumber$|[Mm]ean|[Ss]td",colnames(XY_train))]

#Reorder data by original index and reset row names/numbers
#This is necessary since following joins occur by row number and previous
#merge activity reordered data
XY_train <- XY_train[order(as.numeric(XY_train$OrigRowIndex)),]
rownames(XY_train) <- NULL

#Delete column in dataset that is no longer necessary
XY_train$OrigRowIndex <- NULL

#Load the subject numbers dataset and merge with the appropriate rows in the dataset
SubjectNumbers_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
XY_train <- merge(SubjectNumbers_train,XY_train,by=0)

#Release memory for storage variables
SubjectNumbers_train <- NULL

#Change datset column name to something more descriptive
colnames(XY_train)[2] <- "Subject"

#Delete column in dataset that is not necessary
XY_train$Row.names <- NULL

#Combine filtered test and training datasets
XY_total <- rbind(XY_test,XY_train)

#Release memory for storage variables
XY_test <- NULL
XY_train <- NULL

#Load activity labels and join to full dataset
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
XY_total <- merge(ActivityLabels,XY_total,by.x="V1",by.y="ActivityNumber")

#Release memory for storage variable
ActivityLabels <- NULL

#Change datset column name to something more descriptive
colnames(XY_total)[2] <- "Activity"

#Delete column in dataset that is no longer necessary
XY_total$V1 <- NULL

MyTidyDataSet <- aggregate(XY_total[,3:88],by=list(Activty=XY_total$Activity,Subject=XY_total$Subject),mean)

#Release memory for storage variables
XY_total <- NULL

#Make the column names easier to work with
names(MyTidyDataSet) <- gsub("\\(\\)|-|,","",names(MyTidyDataSet))
names(MyTidyDataSet) <- gsub("std","Std",names(MyTidyDataSet))
names(MyTidyDataSet) <- gsub("mean","Mean",names(MyTidyDataSet))

#write tidy dataset out to file in current working directory
write.table(MyTidyDataSet,"TidyDataset.txt",sep="\t",row.names = FALSE)