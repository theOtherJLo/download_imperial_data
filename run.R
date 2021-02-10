# This script is what gets run by github actions 

# Install packages ---------------------
# This is a simple approach (i.e. not using containers)
# but it might work for this example
install.packages("assertthat")

# Load data -------------------
data <- read.csv('https://imperialcollegelondon.github.io/covid19local/downloads/UK_hotspot_projections.csv')

# Check if data has changed 
if(file.exists("imperial_hotspot_projections.csv")){
  saved_data <- read.csv("imperial_hotspot_projections.csv")
  data_same <- assertthat::are_equal(saved_data, data)
} else data_same <- FALSE

metadata <- data.frame(date = Sys.Date(), time = Sys.time(), data_same = data_same)

# Save data ----------------------
write.csv(metadata, file = "metadata.csv", row.names = FALSE)
if(!data_same) write.csv(data, file = "imperial_hotspot_projections.csv", row.names = FALSE) # Only save if it has changed

message(file.exists("imperial_hotspot_projections.csv"))

# If the data hasn't changed, we get an error as the action can't complete

# There are three options we can take, in increasing complexity:
# 1) Just have a "latest update" csv which always means something would have changed (or alternatively, a log)
# 2) Use conditional statements in the github actions 
# 3) Split the action into two tasks, one that checks if the data has changed, and one which saves it if it has

# As we are just doing this as an MVP, we will go with option 1 for now 



