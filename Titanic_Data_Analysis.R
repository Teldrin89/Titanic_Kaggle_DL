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

# to load an additional package it has to be installed first - using install.packages function
library(ggplot2)
# the ggplot2 library will be helpfull with some graphical representation of data

# first, the machine learning model will be trained using only train data frame, so the change of Pclass to factors also
# has to be applied to train data frame
train$Pclass <- as.factor(train$Pclass)

# --Hypothesis-- - check the survival rate among different class of people (assuming high class having higher survival 
# rate) use a "ggplot" function from "ggplot2" library
ggplot(train, aes(x = Pclass, fill=factor(Survived))) + geom_bar(width = 0.5) + xlab("Pclass") + ylab("Total Count") 
+ labs(fill = "Survived")
# ggplot takes the data as first variable (train), then the "aes" is generating the way the graph is going to look: it
# will have an "X" axis as Pclass, the fill variable (that will be based on Survived factor - using the factor function
# on the fly), then specifing that the chart will be a bar chart (with specific width of a bar) with labels added to X and
# Y axes and legend labeld "Survived"
# as suspected, assuming each class individually, the highest survival rate is for 1st class passengers, then it's going
# down for 2nd and further down for 3rd

# to check just a sample of the portion of data frame use a "head" function - will print the first 5 rows by default
head(as.character(train$Name))
# since the Name has been labeld as factor in a data frame the "as" function will change on the fly variable type to
# character for more clear presentation of the column head
# the names seem to be formated in a specific way, as in last name, title, first name, etc.
# to determine how many uniqe names are between both train and test data sets use a "unique" function and "length" on top
# first treating the name as characters
length(unique(as.character(data.combined$Name)))
# the value is 1307 which means there are some exactly same names in the data set - now it has to be verified if the 
# proble is a duplicate name (so eliminate) or it's just a matter of the same name (but still 2 different people)
# extract the duplicate name data to new variable
dup.names <- as.character(data.combined[which(duplicated(as.character(data.combined$Name))), "Name"])
# the result shows that there are 2 names: "Kelly, Mr. James" and "Connolly, Miss. Kate" that occure twice
# to check the whole information about the duplicated names use the same function but checking the new variable dup.names
# against the whole data.combined iterativly and only take the data when found
data.combined[which(data.combined$Name %in% dup.names),]
# from 4 lines in console that are results of this function it looks as these were 4 different people - no need to adjsut
# the data frame

# load the stringr library for handling of the string format variables
library(stringr)

# --Hypothesis-- is there any corelation between the Mr. or Miss. titles and the other parameters, like sbisp?
# in the misses variable there will be stored a data extracted from data.combined using the "str_detect" checking the 
# Name column by the title ("Miss")
misses <- data.combined[which(str_detect(data.combined$Name, "Miss")),]
# the next command will printout the first 6 rows of the misses data
misses[1:6,]
# the information that we can infere from that small data sample is that all had generaly low age, most of them survived
# and the very youg one were most likely traveling with either sibling (sibsp = siblings/spouses) or parents 
# (parch = parents/children)
# checking if the "Mrs." and corelation with age
mrses <- data.combined[which(str_detect(data.combined$Name, "Mrs.")),]
# printout the first 6 rows
mrses[1:6,]
# the trend for survivability seem to be continuig, the age of "Mrs." seem to be older, most traveling with probably 
# spouse (rather than sibling)
# checking the pattern for men - rather than looking by title, using the "sex" factor as child male may have no "Mr."
males <- data.combined[which(train$Sex == "male"),]
males[1:6,]
# from the male only it looks as survival rate was extremely low (all first 6 did not survive) with variable age and most
# in 3rd class

# --Hypothesis-- expand upon the realtionship between "survived" and "pclass" byt adding the new "title" variable to the
# data set and then explore a potential 3-dimensional relationship
# create a utility function to help with title extraction from name variables
extractTitle <- function(name){
  # change the type of name variable to characters
  name <- as.character(name)
  # run the if statement to check which title shall be filled to which name
  # the function "grep" check the given string against antoher (if it is in there); then if the length of that result is
  # bigger than 1 it means it found it and returns the string
  if(length(grep("Miss.", name))>0){
    return("Miss.")
  } else if(length(grep("Master."))>0){
    return("Master.")
  } else if(length(grep("Mrs."))>0){
    return("Mrs.")
  } else if(length(grep("Mr."))>0){
    return("Mr.")
    # return "Other" in case no title is found
  } else {
    return("Other")
  }
}


