# getdata-011-proj
Course project for Coursera course "Getting and Cleaning Data"

## Files

### R scripts
* download.R: Script containing the download() function to download and unzip the raw dataset
* run_analysis.R: Script that run through the transformations as described in the Code Book
    + The following steps were taken to transform the raw data into the final tidy dataset:
        1. All of the aforementioned files were read into data frames
        2. Training and testing sets for each data type (X, y, subject) were repsectively row binded (rbind) together to form a single feature, label, and subject sets. The training set always preceded the testing sets in the rbind() to ensure the order of the data is maintained
        3. The name of each feature was set as the column names for the feature set
        4. The feature set was subsetted so that only the mean and standard deviation featrues were remaining (feature names that contain "mean() or std()")
        5. The subsetted feature, label, and subject datasets were column-binded (cbind) together to form a master set (master.all)
        6. master.all was merged with the activity labels set so that the activity description is added to master.all. The activity ID was removed from master.all since with the description, it became redundant.
        7. The column names in the master set was then cleaned up (all lowercase, no brackets)
        8. Using the plyr library, a new dataset (ave.vars) was created from master.all by grouping by activity description and subject id, and applying the column mean based on this grouping
        9. All column names except activity description and subject id were prefixed with a "average-" to indicate that these are averages
        10. ave.vars is then written to file as averages.txt with a whitespace(" ") as the delimiter

### R markdown
* codebook.md: Code Book describing the raw dataset, the tidy dataset, and how the raw dataset was transformed into the tidy dataset
* README.md: This file

## Instructions
Open run_analysis.R, and change the following in line 2:
* From: setwd("~/Coursera/Getting\_and_\Cleaning_Data/getdata-011-proj/")
* From: setwd("[directory where run\_analysis.R and download.R resides]")
Then simply run the script from beginning to end. The resulting tiday data set should be found as "averages.txt" in the working directoy.


