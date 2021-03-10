This codebook describes the raw data, the variables contained therein, and the
methods used to clean the dataset into its final form.

The raw data
------------

Source:

Jorge L. Reyes-Ortiz(1,2)
Davide Anguita(1)
Alessandro Ghio(1)
Luca Oneto(1)
Xavier Parra(2)

1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.

2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain

activityrecognition '@' smartlab.ws

Description
-----------

30 volunteers (aged 19-48) performed six different activities while wearing a
Samsung Galaxy S II smartphone on their waist.  The activities were: walking,
walking upstairs, walking downstairs, sitting, standing, and laying.
Using the accelerometer and gyroscope in the phone, they captured linear
acceleration and angular velocity along all three dimensional axes.

Variables
---------

The raw data was captured in the variables tAcc-XYZ and tGyro-XYZ, and then
passed through filters to reduce the amount of noise.  The acceleration
variable was then separated into two variables (tBodyAcc and tGravityAcc,
each with three-dimensional components) to specify data directly pertaining to
the motion of the wearer and data pertaining to the effects of gravity.
The gyroscope data was filtered into the new variable tBodyGyro, also with
three-dimensional components.  All other variables from the dataset were
derived and calculated from these base variables, so the decision was made to
present a dataset that was closest to the original for the purposes of allowing
others to glean what insights they could from the beginning dataset.

Methodology
-----------

As all of the data are in separate txt files, the inital challenge is to
construct an entire dataframe from its constituent parts.  After reviewing
the README, features, and features_info txt files, we begin to see how this all
will piece together.

First we read each of the necessary txt files into R using read.table.

We can see that the activities are numbered and have their own index, so we
first combine the subject labels (subject_test, subject_train) with their
corresponding activity label number (y_test, y_train).  We can then use the
master activity_label index to assign the activity name to each subject,
rather than using the number.  Sorting by subject number will then have all of
our data neatly in order to be further combined.

The X_test and X_train files have the data to match our aforementioned
subject/activity columns, but first, by taking the transpose of the features
column, we can provide column labels for all of the data points.  Once the data
columns are labeled, we can cbind our two dataframes and have a complete dataset
for both the training data and the test data.

To see the data all together, an rbind of the two data frames will suffice,
with one final re-ordering by subject number for ease of reading.

Means and Standard Deviations
-----------------------------

We will use regular expression searches to reduce our dataset down to the
columns of subject, activity, and columns with either mean or standard deviation
data.  Using the pipe operator and value=TRUE will allow us to create a list of
character vectors that we can use to subset the dataframe.  Finally, for
formatting's sake, we will change all of the column names to lowercase to avoid
any camel case mishaps when typing column names.

Final manipulations
-------------------

We will create a cross-tabulation to explore one of the variables in the final
dataset.  By using mutate, we can create a variable that is the sum of total
body acceleration in all three dimensions (X,Y,and Z) for each observation in
the dataset.  We can then produce a table showing the means of these sums,
sorted by both activity and subject.  This can be adapted to any variable by
changing the variable name in the code lines for the mutation and the xtabs calls.
