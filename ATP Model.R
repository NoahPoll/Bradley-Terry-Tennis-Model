
# Load required packages
library(BradleyTerry2)

# Step 1: Load the data
atp_data <- read.csv("C:/Users/noahd/Downloads/23-24 Tennis Data.csv")

# Step 2: Preprocess the data (if necessary)
atp_data <- atp_data[complete.cases(atp_data$Winner) & complete.cases(atp_data$Loser), ]

# Convert Winner and Loser columns to factors with the same levels
atp_data$Winner <- factor(atp_data$Winner)
atp_data$Loser <- factor(atp_data$Loser, levels = levels(atp_data$Winner))

# Fit the Bradley-Terry model
bt_model <- BTm(outcome = Winner,
                player1 = Winner,
                player2 = Loser,
                data = atp_data)

# Summary of the model
summary(bt_model)

# Obtain player rankings
player_rankings <- predict(bt_model, type = "response")

# Convert Winner and Loser to factors with the same levels as in the original data
new_winner <- factor("Alcaraz C.", levels = levels(atp_data$Winner))
new_loser <- factor("Djokovic N.", levels = levels(atp_data$Loser))

# Make predictions
predict(bt_model, newdata = data.frame(Winner = new_winner, Loser = new_loser), type = "response")


