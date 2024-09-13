library('dplyr')
library('readr')
library('lubridate')
library('ggplot2')


# This code produces the GCC monthly mean from each day of the month at 12:00 p.m.


# Function to process a single csvfile
process_csv <- function(csv_file) {
  # Read the CSV data
  df <- read_csv(csv_file)
  
  # Check if 'date' column exists
  if (!is.null(df$date)) {
    # Print structure before conversion (optional)
    # print(str(df$date))
    
    # Convert 'date' to datetime format (assuming 'date' column exists)
    df$date <- as.POSIXct(df$date, format = "%m/%d/%Y %H:%M:%S %p")  # Adjust format for PM/AM
  } else {
    # Handle missing 'date' column (optional - print a message or skip processing)
    warning("CSV file ", csv_file, " is missing 'date' column")
    return(NULL)  # Or perform alternative actions if 'date' is missing
  }
  
  # Filter for rows where time is 12:00 (assuming conversion worked)
  df_filtered <- df[hour(df$date) == 12 & minute(df$date) == 0, ]
  
  # Calculate monthly mean of gcc (assuming 'gcc' column exists)
  monthly_mean <- df_filtered %>% group_by(month = month(df_filtered$date)) %>% summarise(mean(gcc))
  
  # Return the monthly mean for this csv
  return(monthly_mean)
}

# Set the directory containing your csv (replace with your actual path)
csv_dir <- "D:/Phenocam/raw_daily_VI/"

# Combine monthly means from cvs
all_means <- sapply(list.files(csv_dir, full.names = TRUE), process_csv, simplify = FALSE)

# Aggregate monthly means across all csvs
combined_means <- NULL
for (monthly_mean_list in all_means) {
  if (!is.null(monthly_mean_list)) {
    combined_means <- rbind(combined_means, monthly_mean_list)
  }
}

# Calculate overall mean for each month
combined_means <- combined_means %>%
  group_by(month) %>%
  summarise(mean_gcc = mean(`mean(gcc)`))

monthly_GCC <- write.csv(combined_means, file = "monthly_GCC.csv", row.names = FALSE)

# Convert month numbers to month names
combined_means$month <- factor(combined_means$month, levels = 1:12, labels = month.abb)

# Plot: Monthly Mean Results
title <- "GCC Monthly Mean"
ggplot(combined_means, aes(x = month, y = mean_gcc)) +
  geom_point(col = 'forestgreen') +
  geom_line(col = 'forestgreen', group = 1) +
  ggtitle(title) +
  xlab('Month') +
  ylab('GCC Average') +
  scale_x_discrete(labels = month.abb) +
  theme_classic() 

# Save plot
ggsave(filename = "Monthly_GCC.png", width = 8, height = 6)