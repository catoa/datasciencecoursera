packages <- c("data.table", "reshape2", "dplyr")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

path <- "UCI Har Dataset"

features <- fread(file.path(path, "features.txt"))
names(features) <- c("feature_num", "feature_name")
feature_indices <- grep(".*[Mm]ean.*|.*std.*", features$feature_name)

train_subject_data <- fread(file.path(path, "train", "subject_train.txt"))
test_subject_data <- fread(file.path(path, "test", "subject_test.txt"))

train_X_data <- fread(file.path(path, "train", "X_train.txt"), select = feature_indices)
test_X_data <- fread(file.path(path, "test", "X_test.txt"), select = feature_indices)

train_y_data <- fread(file.path(path, "train", "y_train.txt"))
test_y_data <- fread(file.path(path, "test", "y_test.txt"))

activities <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS',
                'SITTING', 'STANDING', 'LAYING')

subject_combined <- rbind(train_subject_data, test_subject_data)
names(subject_combined) <- c("Subject")
X_combined <- rbind(train_X_data, test_X_data)

get_tidy_data <- function() {
    
}

get_wanted_features <- function() {
    feature_wanted <- features[feature_indices, ]
    feature_wanted$feature_name <- gsub("\\(\\)", "", feature_wanted$feature_name)
    feature_wanted$feature_name <- gsub("-", "", feature_wanted$feature_name)
    feature_wanted$feature_name <- gsub("mean", "Mean", feature_wanted$feature_name)
    feature_wanted$feature_name <- gsub("std", "Std", feature_wanted$feature_name)
    names(X_combined) <- feature_wanted$feature_name    
}

get_aggregate <- function(data) {
    options(warn=-1)
    data <- aggregate(data, by = list(Subject = data$Subject, Activity = data$Activity), mean)
    data <- data[, -(3:4)]
    options(warn=0)
}

y_combined <- rbind(train_y_data, test_y_data)

data <- cbind(subject_combined, y_combined, X_combined)

data$V1 <- as.factor(data$V1)
levels(data$V1) <- activities

data <- rename(data, Activity = V1)