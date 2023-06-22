library(httr)
library(jsonlite)
library(dplyr)


# Function to append new data to existing JSON file
append_to_json <- function(new_data) {
  # Check if file exists
 file_path <- ("filepath//file.json")
 if (file.exists(file_path)) {
    # Read existing data from the JSON file
    existing_data <- jsonlite::fromJSON(file_path)
    # Extract items from existing data
    existing_items <- existing_data$data$data
    # Extract items from new data
    new_items <- new_data$data$data
    # Check if new data has 'time' column
    if ("time" %in% names(new_items)) {
      # Remove duplicates
      new_items <- new_items[!new_items$"time" %in% existing_items$"time", ]
    }
    # Combine existing and new items into a single data frame
    combined_items <- bind_rows(existing_items, new_items)
    # Write updated data to JSON file
    jsonlite::write_json(list(data = list(items = combined_items)), file_path)
  } else {
    # Write new data to file
    jsonlite::write_json(new_data, file_path)
  }
}


# fetch data from the API and append it to the JSON file
fetch_and_append_data <- function(new_data) {
  # Make GET request to API
  response <- GET("URL")
  # Parse response JSON
  data <- fromJSON(content(response, "text"))
  # Append new data to JSON file
  append_to_json(data)
}

# Set the time for repeat (interval) (in seconds)(1 day)
time_interval <- 86400

# Fetch data from the API and append it to the JSON file
fetch_and_append_data()

# Repeat fetching data
repeat {
  Sys.sleep(time_interval)
  fetch_and_append_data()
}
