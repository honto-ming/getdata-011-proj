download <- function() {
    # create a directory for downloads if it doesnt't exist
    if(!file.exists("./downloads")) { dir.create("./downloads/") }
    ## download & unzip the file
    fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile="./downloads/UCI_HAR_Dataset.zip", method ="curl")
    ## unzip the file
    unzip("./downloads/UCI_HAR_Dataset.zip", exdir="./")
    }
