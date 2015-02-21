---
title: "Code Book"
author: "Honto Ming"
date: '2015-02-15'
output: html_document
---
## The Raw Dataset
The raw dataset come from the Human Activity Recognition Using Smartphones Dataset (v1.0) which can be found on the UCI Machine Learning Reposity [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The raw dataset contains readings from sensors on a smartphone that a subject was wearing while performing 6 distinct activities. These sensor readingss were transformed with statistic methods such as mean and standard deviation into into variables. For a full description of the raw dataset, please use the link above.  

## The Tidy Dataset
### Summary of dataset
The final tidy dataset can be found in the file "averages.txt"

This dataset contains information on the data collected 

There are 68 variables in the tidy dataset, with 2 factor variables describing the activity the person was doign, and an identifier for the subject performing the activity. The remaining 66 variables contain the average of each raw data set's variable statistic for each activity and each subject. Example:

* average-tbodyacc-mean-y
    + *average* = "*average* of"
    + *tboyacc-mean-y* = "*mean* of *tbodyacc* on the *y* axis"

### Full list of variables
Below is the list of all 68 variables along with a description of each where appropriate. Note that the following list is in order from left to right in the tidy dataset:

1. activityname: Factor with 6 levels ("LAYING", "SITTING", "STANDING", "WALKING", "WALKING\_DOWNSTAIRS", "WALKING\_UPSTAIRS")
2. subjectid: Character factoer between 1-30
3. average-tbodyacc-mean-x: Numeric. Average of the values for the activity name and subjectid of tbodyacc-mean-x in the raw dataset.
    + **Note 1**: The remaining variables (4-68) are similar to the variabel just described (3). The only exception is that it is the average of a different set of variables/values from the _raw_ data set
    + **Note 2**: See the "Summary of dataset" section above for additional information on how to interpret the remaining variables in the tidy data set.
4. average-tbodyacc-mean-y
5. average-tbodyacc-mean-z
6. average-tbodyacc-std-x
7. average-tbodyacc-std-y
8. average-tbodyacc-std-z
9. average-tgravityacc-mean-x
10. average-tgravityacc-mean-y
11. average-tgravityacc-mean-z
12. average-tgravityacc-std-x
13. average-tgravityacc-std-y
14. average-tgravityacc-std-z
15. average-tbodyaccjerk-mean-x
16. average-tbodyaccjerk-mean-y
17. average-tbodyaccjerk-mean-z
18. average-tbodyaccjerk-std-x
19. average-tbodyaccjerk-std-y
20. average-tbodyaccjerk-std-z
21. average-tbodygyro-mean-x
22. average-tbodygyro-mean-y
23. average-tbodygyro-mean-z
24. average-tbodygyro-std-x
25. average-tbodygyro-std-y
26. average-tbodygyro-std-z
27. average-tbodygyrojerk-mean-x
28. average-tbodygyrojerk-mean-y
29. average-tbodygyrojerk-mean-z
30. average-tbodygyrojerk-std-x
31. average-tbodygyrojerk-std-y
32. average-tbodygyrojerk-std-z
33. average-tbodyaccmag-mean
34. average-tbodyaccmag-std
35. average-tgravityaccmag-mean
36. average-tgravityaccmag-std
37. average-tbodyaccjerkmag-mean
38. average-tbodyaccjerkmag-std
39. average-tbodygyromag-mean
40. average-tbodygyromag-std
41. average-tbodygyrojerkmag-mean
42. average-tbodygyrojerkmag-std
43. average-fbodyacc-mean-x
44. average-fbodyacc-mean-y
45. average-fbodyacc-mean-z
46. average-fbodyacc-std-x
47. average-fbodyacc-std-y
48. average-fbodyacc-std-z
49. average-fbodyaccjerk-mean-x
50. average-fbodyaccjerk-mean-y
51. average-fbodyaccjerk-mean-z
52. average-fbodyaccjerk-std-x
53. average-fbodyaccjerk-std-y
54. average-fbodyaccjerk-std-z
55. average-fbodygyro-mean-x
56. average-fbodygyro-mean-y
57. average-fbodygyro-mean-z
58. average-fbodygyro-std-x
59. average-fbodygyro-std-y
60. average-fbodygyro-std-z
61. average-fbodyaccmag-mean
62. average-fbodyaccmag-std
63. average-fbodybodyaccjerkmag-mean
64. average-fbodybodyaccjerkmag-std
65. average-fbodybodygyromag-mean
66. average-fbodybodygyromag-std
67. average-fbodybodygyrojerkmag-mean
68. average-fbodybodygyrojerkmag-std

## Data Transformation
The raw data is separated into a number of files/subsets. The subsets used to obtain the tidy data set is as follows:
* X\_train: Training feature set containing 7352 561-feature vectors
* Y\_train: Training labels containing the activity identifier for each of the 7352 561-feature vectors in X\_train
* subject\_train: The subject identifier for each of the 7352 561-feature vectors in X\_train (i.e. which subject performed the activity)
* X\_test: Testing feature set containing 2947 561-feature vectors
* Y\_test: Testing labels containing the activity identifier for each of the 2947 561-feature vectors in X\_test
* subject\_test: The subject identifier for each of the 2947 561-feature vectors in X\_test (i.e. which subject performed the activity)
* activity\_labels: A lookup table mapping activity identifier to activity description
* features.txt: The name of each feature in the 561-feature vector in X\_train and X\_test

The following steps were taken to transform the raw data into the final tidy dataset:

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
