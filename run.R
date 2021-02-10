# This script is what gets run by github actions 

# Load data -------------------
data <- read.csv('https://imperialcollegelondon.github.io/covid19local/downloads/UK_hotspot_projections.csv')

# Save data ----------------------
write.csv(data, file = "imperial_hotspot_projections.csv")


