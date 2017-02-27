packages <- c("data.table", "reshape2", "dplyr")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

PATH <- "UCI Har Dataset"

features <- fread(file.path(PATH, "features.txt"))
names(features) <- c("feature_num", "feature_name")

get_feature_indices <- function() {
    feature_indices <- grep(".*[Mm]ean.*|.*std.*", features$feature_name)
    return (feature_indices)
}

wanted_feat_indices <- get_feature_indices()

feature_wanted <- features[wanted_feat_indices, ]
feature_wanted$feature_name <- gsub("\\(\\)", "", feature_wanted$feature_name)
feature_wanted$feature_name <- gsub("-", "", feature_wanted$feature_name)
feature_wanted$feature_name <- gsub("mean", "Mean", feature_wanted$feature_name)
feature_wanted$feature_name <- gsub("std", "Std", feature_wanted$feature_name)

get_aggregate <- function(data) {
    data <- aggregate(data, by = list(Subject = data$Subject, Activity = data$Activity), mean)
    data <- data[, -(3:4)]
    return (data)
}

get_subject_data <- function() {
    train_subject_data <- fread(file.path(PATH, "train", "subject_train.txt"))
    test_subject_data <- fread(file.path(PATH, "test", "subject_test.txt"))
    
    subject_combined <- rbind(train_subject_data, test_subject_data)
    names(subject_combined) <- c("Subject")
    return (subject_combined)
}

get_measurements <- function() {
    train_X_data <- fread(file.path(PATH, "train", "X_train.txt"), select = wanted_feat_indices)
    test_X_data <- fread(file.path(PATH, "test", "X_test.txt"), select = wanted_feat_indices)
    
    X_combined <- rbind(train_X_data, test_X_data)
    names(X_combined) <- feature_wanted$feature_name 
    return (X_combined)
}

get_activity_labels <- function() {
    activities <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS',
                    'SITTING', 'STANDING', 'LAYING')
    
    train_y_data <- fread(file.path(PATH, "train", "y_train.txt"))
    test_y_data <- fread(file.path(PATH, "test", "y_test.txt"))
    
    y_combined <- rbind(train_y_data, test_y_data)
    y_combined <- as.factor(unlist(y_combined))
    levels(y_combined) <- activities
    
    return (y_combined)
}

get_tidy_data <- function() {
    subjects <- get_subject_data()
    activity <- get_activity_labels()
    measurements <- get_measurements()
    
    data <- cbind(subjects, activity, measurements)
    
    data <- rename(data, Activity = activity)
    
    agg_data <- get_aggregate(data)
    return (agg_data)
}

options(warn = -1)
agg_data <- get_tidy_data()
options(warn = 0)
response <- readline(prompt="Would you like to write this to file? (y/n) ")

if (response == "y") 
    write.table(agg_data, file = "output.txt")