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

# to pass the structure of a given object use str function - results in console
str(data.combined)
# the "Survived" column is a variable of type character (due to the fact that after combining the 2 data sets there are 
# "NaN")
# the "PassangerId", "Pclass", "SibSp" and "Parch" are an integer type - all total numbers
# the "Age" and "Fare" are numerical type - meaning the values can have a decimal or the cell might be empty ("NA")
# the "Name" and "Sex" are a factor type vriables - for example in sex example there are 2 options: male and female and
# to that the assigned factors are 2 and 1

# Pclass - that represents the class of a ticket of given passanger - is currently an integer and given the fact that in
# some way it implies the social status of a given person it should be treated as a factor, the same story can be applied
# to the survived values (which now are treated as character)

# to adress a specific column in data frame use "$" sign and then to transform the type of variable use "as" function with
# factor atribute
data.combined$Pclass <- as.factor(data.combined$Pclass)
data.combined$Survived <- as.factor(data.combined$Survived)

# to take a look at gross survival rate, simply printout the factors and numbers from combined data frame
table(data.combined$Survived)
# the train data shows that more people died than survived but the ratio is not skewed towards one or the other which
# is good from the machine learning algorith design perspective

# take a look at the distribution of pclass factor
table(data.combined$Pclass)
# we can see that there have been much more 3rd class passengers than any others but also that there were more 1st class
# than the 2nd class (which may indicate why there have been so many survived passengers)


