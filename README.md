# run_analysis
Samsung Galaxy S smartphone accelerometer data analysis

The run_analysis script is fully automated - it will create any necessary
directories, download and unzip the essential file(s), and perform all of the
manipulations outlined in the CodeBook.  In the end, you will have one
dataframe of the training data, one dataframe of the test data, a combined
training/test dataframe, and the final tidy dataset of the averages of one of
the variables by activity and by subject.  It will print the final cross-tab
to the console and output it to a tab-separated text file in the initial
working directory (one level up from the data text files).