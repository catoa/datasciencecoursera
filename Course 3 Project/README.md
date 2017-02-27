# Getting and Cleaning Data: Course Project

## The provided `run_analysis.R` script contains functions that aid in the tidying up of the UCI Har Dataset.

## The script is broken down into multiple helper functions which produce the resulting cleaned data.

### Functions:

* `get_feature_indices()`: returns a vector of mean/std columns indices
* `get_subject_data()`: pulls in the subject data from the UCI Har Dataset directory
* `get_activity_labels()`: retrieves in the Activity data from the UCI Har Dataset directory
* `get_measurements()`: retrieves measurement data from the UCI Har Dataset directory
* `get_tidy_data()`: combines the data into a single data.table
* `get_aggregate()`: aggregates the data, grouping the data by subject and activity

#### After sourcing the script, you will be prompted to write out the data into a text file named `output.txt`
