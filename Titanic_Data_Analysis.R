# Comments in R are prefixed the same way a sin Python
# Test Data and Train Data for the Titanic competiotion

# Load raw data for both test and train sets in csv format with headers
train <- read.csv("train.csv", header = TRUE)
test <- read.csv("test.csv", header = TRUE)

# The files read are now available as variables in enviroment and the file format now is data frame - a particular R
# format type for tabular information
# The train data has one more column - Survived - that tells us who lived and who died. Using this data and set of
# parameters that are available in other colums the task is to create a model that will predict if given passanger
# will survive or not based on the test data.

# Create a new data frame using the test data set and add one more column for keeping the same format and having a 
# Survived column that will store the value while testing of the model
test.survived <- data.frame(Survived = rep("None", nrow(test)), test[,])
# data.frame() function will create a new data frame, adding a variable "Survived" using the replicate function (rep)
# to repeat the value of "None", repeating the process for number of rows of test data frame and then combine it with
# test data frame (leaving it blank in [,] means to take all rows and columns)


# Swap the first 2 columns to have the exact same structure in test and train data frames
test.survived <- test.survived[c(2,1,3,4,5,6,7,8,9,10, 11,12)]

# Combine the 2 data frames - test and train - which is now available due to consistent size
data.combined <- rbind(train, test.survived)
# use the rbind function that combines the data frames by rows
