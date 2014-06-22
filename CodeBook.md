Variables
=====
Variable names are stored in:
UCI HAR Dataset/features.txt

Subject data and Activity data are stored under those variable names and cbound to the data.

Data
=====
The raw data is stored in:
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/test/X_test.txt

The names corresponding to the data variables are stored in:
UCI HAR Dataset/features.txt

The subject data is stored in: 
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/train/subject_train.txt

The activity data is stored in:
UCI HAR Dataset/train/y_train.txt
UCI HAR Dataset/test/y_test.txt

The activity labels are store in:
UCI HAR Dataset/activity_labels.txt

Transformations
=====
run_analysis makes two tidy data set files.

tidydata.txt

The function run_analysis reads the data from the X_train, and X_test files combines them using rbindswith datatrain listed first.
run_analysis cleans then reads the features files, and cleans the names of the variables, by gsubbing out "(",")",",","-" and " ".
Once cleaned, it names the dataset variable with the cleaned feature names. 
Next using the grep function it truncates the dataset to only include variables with "mean" or "std" in the name.This is saved as datasettotal
Next it reads the subject data from train and text, rbinds it.
It reads the activity data from train and text and rbinds it. It then reads the activity labels file and applies the labels to the activity data.
Finally it cbinds subject, activity and data variables, and prints this in a .txt file

tidydataaverages.txt

run_analysis loops through the subjects and a nested loop through activities, and rbinds these to a finaldataset variable.
It reassigns labals from the features file to the dataset, and prints it as a dataframe in a .txt file

