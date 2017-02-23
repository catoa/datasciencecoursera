packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

path <- "UCI Har Dataset"

# Subject data
train_subject_data <- fread(file.path(path, "train", "subject_train.txt"))
test_subject_data <- fread(file.path(path, "test", "subject_test.txt"))
# X data? --> what is this?
train_X_data <- fread(file.path(path, "train", "X_train.txt"))
test_X_data <- fread(file.path(path, "test", "X_test.txt"))
# y data? --> what is this? 
train_y_data <- fread(file.path(path, "train", "y_train.txt"))
test_y_data <- fread(file.path(path, "test", "y_test.txt"))

feature_names <- fread(file.path(path, "features.txt"))
names(feature_names) <- c("feature_num", "feature_name")

activities <- c('WALKING', 'WALKING_UPSAIRS', 'WALKING_DOWNSTAIRS',
                'SITTING', 'STANDING', 'LAYING')

subject_combined <- rbind(train_subject_data, test_subject_data)
names(subject_combined) <- c("Subject")
X_combined <- rbind(train_X_data, test_X_data)
names(X_combined) <- feature_names$feature_name
y_combined <- rbind(train_y_data, test_y_data)

data <- cbind(subject_combined, y_combined, X_combined)
data$V1 <- as.factor(data$V1)
levels(data$V1) <- activities

columnMeans <- colMeans(data[,-(1:2)])

columnSds <- lapply(data[,-(1:2)], sd)


