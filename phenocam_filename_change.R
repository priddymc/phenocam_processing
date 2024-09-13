# Set the working directory to the folder containing the files
# This will need to be done for each month
setwd("D:/Phenocam/RRC/2024/February/IMG")

# List all files 
files <- list.files()

# Rename each file
for (file in files) {
  new_name <- gsub("_", "-", file)  # Replace underscores with hyphens
  file.rename(file, new_name)  # Rename the file
}
