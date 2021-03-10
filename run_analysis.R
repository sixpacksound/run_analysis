## Load libraries we will be using

library(dplyr)

## Establish existence of working directory and set

if(!dir.exists("~/R/run_analysis")) {dir.create("~R/run_analysis")}
setwd("~/R/run_analysis")

## Download ZIP file containing data from the internet

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")

## Unzip download and extract files (flatten into one directory
## for ease of reading into R)

unzip("dataset.zip", junkpaths = TRUE, exdir = "Data")
setwd("~/R/run_analysis/Data")

## Read necessary files into R and create corresponding data frames

activity_label <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subj_test <- read.table("subject_test.txt")
data_test <- read.table("X_test.txt")
label_test <- read.table("y_test.txt")
subj_train <- read.table("subject_train.txt")
data_train <- read.table("X_train.txt")
label_train <- read.table("y_train.txt")

## Join all of the training data into one cohesive dataframe

tmp <- cbind(subj_train, label_train)
colnames(tmp) <- c("subj", "act")
act_train <- merge(tmp, activity_label, by.x = "act", by.y = "V1")
act_train <- act_train[order(act_train$subj), ] %>%
        select(subj, V2) %>% rename("subject" = subj, "activity" = V2)

df_train <- data_train ; colnames(df_train) <- t(features$V2)
df_train <- cbind(act_train, df_train)
## all of the training data is now together and labeled

## Join all of the test data into one cohesive dataframe

tmp2 <- cbind(subj_test, label_test)
colnames(tmp2) <- c("subj", "act")
act_test <- merge(tmp2, activity_label, by.x = "act", by.y = "V1")
act_test <- act_test[order(act_test$subj), ] %>%
        select(subj, V2) %>% rename("subject" = subj, "activity" = V2)

df_test <- data_test ; colnames(df_test) <- t(features$V2)
df_test <- cbind(act_test, df_test)
## all of the test data is now together and labeled

## Combine training & test dataframes with appropriate column and row labels
## Remove unnecessary variables to declutter

df <- rbind(df_train, df_test)
df <- df[order(df$subject), ]

rem <- grep("df", ls(), value=TRUE, invert=TRUE)
rm(list = rem) ; rm(rem)

## Extract mean and standard deviation columns for each measurement

nmlist <- grep("mean|std", names(df), value = TRUE)

## Refactor dataframe with subject, activity, means, and stdevs

df <- select(df, subject, activity, all_of(nmlist))
names(df) <- tolower(names(df))

## Create second dataset with average of each variable
## for each activity and each subject

df <- mutate(df, "bodyaccsum" = (df$`tbodyacc-mean()-x` +
                                df$`tbodyacc-mean()-y` +
                                df$`tbodyacc-mean()-z`))

## You can change out the variables in the above line and below to
## examine any individual variable in the dataset

tab <- xtabs(bodyaccsum ~ subject + activity,
             aggregate(bodyaccsum~subject+activity, df, mean))

tab

## Change file name below to represent which variable's data you are viewing

setwd("~/R/run_analysis")
write.table(tab, "bodyaccmean.txt", sep="\t")