run_analysis <- function() {
	
	datatrain<-read.table("UCI HAR Dataset/train/X_train.txt",stringsAsFactors=F) #Load raw data
	datatest<-read.table("UCI HAR Dataset/test/X_test.txt",stringsAsFactors=F)
	dataset<-rbind(datatrain,datatest)
	
	names<-read.table("UCI HAR Dataset/features.txt",stringsAsFactors=F)			#Load data names
	names$V2<-gsub("\\(","",names$V2)
	names$V2<-gsub("\\)","",names$V2)								#Make them look nice
	names$V2<-gsub(",","",names$V2)
	names$V2<-gsub(" ","",names$V2)
	names$V2<-gsub("-","",names$V2)
	colnames(dataset)<-names$V2										#Give raw data names
	
	datasetmean<-dataset[grep("mean",names$V2)]						
	datasetstd<-dataset[grep("std",names$V2)]				#Keep only those data containing "std" or "mean"
	datasettotal<-cbind(datasetmean,datasetstd)
	
	testsub<-read.table("UCI HAR Dataset/test/subject_test.txt")
	trainsub<-read.table("UCI HAR Dataset/train/subject_train.txt")
	subject<-rbind(trainsub,testsub)[[1]]							#Get subject id #
	
	trainact<-read.table("UCI HAR Dataset/train/y_train.txt",stringsAsFactors=F)		# Get Activity labels and apply them
	testact<-read.table("UCI HAR Dataset/test/y_test.txt",stringsAsFactors=F)			# to the Activity number
	actlab<-read.table("UCI HAR Dataset/activity_labels.txt")
	acttotal<-rbind(trainact,testact)							
	activity<-sapply(1:dim(acttotal)[1],function(x) actlab$V2[as.numeric(acttotal$V1[x])])
	
	datasettotalact<-cbind(subject,activity,datasettotal)				#combine everything and print
	print(datasettotalact)
	
	finaldataset<-NULL						
	for(i in 1:30){					#make average matrix
  		for(j in actlab[[2]]){
  			if(is.null(finaldataset)) finaldataset<-c(1,j,colMeans(datasettotalact[datasettotalact$subject==i & datasettotalact$activity==j,3:81]))
  			else finaldataset<-rbind(finaldataset,c(i,j,colMeans(datasettotalact[datasettotalact$subject==i & datasettotalact$activity==j,3:81])))
  		}
 	}
 	colnames(finaldataset)<-colnames(datasettotalact)			#reassign labels
	finaldataset<-as.data.frame(finaldataset,row.names=1:180)					#print data frame
	sink("tidydata.txt")
	print(datasettotalact)
	sink()
	sink("tidydataaverages.txt")
	print(finaldataset)
	sink()
}