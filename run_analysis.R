##..........Data is already downloaded...........

# ..........Test Data............
XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest<- read.table("UCI HAR Dataset/test/subject_test.txt")

## .............Train Data............

XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain<- read.table("UCI HAR Dataset/train/subject_train.txt")

## .............The data feature and activity............
features<- read.table("UCI HAR Dataset/features.txt")
activity<- read.table("UCI HAR Dataset/activity_labels.txt")

##...........Part1...........
X<- rbind(XTest, XTrain)
Y<- rbind(YTest, YTrain)
Subject<- rbind(SubjectTest, SubjectTrain)
dim(X)
dim(Y)
dim(Subject)


##..........Part 2.............

index<-grep("mean\\(\\)|std\\(\\)", features[,2])
length(index)

X<-X[, index]
dim(X)


##......Part 3.........

Y[,1]<- activity[Y[,1],2]
head(Y)

##............Part 4.............
names<- features[index,2]
names(X)<-names
names(Subject)<-"SubjectID"
names(Y)<-"Activity"
CleanedData<- cbind(Subject, Y, X)
head(CleanedData[,c(1:4)])

##.............creates a second, independent tidy data................
CleanedData<-data.table(CleanedData)
TidyData <- CleanedData[, lapply(.SD, mean), by = 'SubjectID,Activity'] 
dim(TidyData)
write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
head(TidyData[order(SubjectID)][,c(1:4), with = FALSE],12) 

