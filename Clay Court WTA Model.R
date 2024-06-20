# Step 1: Load the data
clay_wta_data <- read.csv("C:/Users/noahd/OneDrive/WTA 23-24 Clay Data.csv")

# Step 2: Preprocess the data (if necessary)
clay_wta_data <- clay_wta_data[complete.cases(clay_wta_data$Winner) & complete.cases(clay_wta_data$Loser), ]

# Convert Winner and Loser columns to factors with the same levels
clay_wta_data$Winner <- factor(clay_wta_data$Winner)
clay_wta_data$Loser <- factor(clay_wta_data$Loser, levels = levels(clay_wta_data$Winner))

# Fit the Bradley-Terry model
bt_model <- BTm(outcome = Winner,
                player1 = Winner,
                player2 = Loser,
                data = clay_wta_data)

# Summary of the model
summary(bt_model)



# Obtain player rankings
player_rankings <- predict(bt_model, type = "response")

# Show the player rankings
player_rankings



# Convert Winner and Loser to factors with the same levels as in the original data
new_winner <- factor("Collins D.", levels = levels(clay_wta_data$Winner))
new_loser <- factor("Jabeur O.", levels = levels(clay_wta_data$Loser))

# Make predictions
predict(bt_model, newdata = data.frame(Winner = new_winner, Loser = new_loser), type = "response")

