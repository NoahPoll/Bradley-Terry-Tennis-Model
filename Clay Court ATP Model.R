# Step 1: Load the data
atp_clay_data <- read.csv("C:/Users/noahd/OneDrive/23-24 Clay Court Data.csv")

# Step 2: Preprocess the data (if necessary)
atp_clay_data <- atp_clay_data[complete.cases(atp_clay_data$Winner) & complete.cases(atp_clay_data$Loser), ]

# Convert Winner and Loser columns to factors with the same levels
atp_clay_data$Winner <- factor(atp_clay_data$Winner)
atp_clay_data$Loser <- factor(atp_clay_data$Loser, levels = levels(atp_clay_data$Winner))

# Fit the Bradley-Terry model
bt_model <- BTm(outcome = Winner,
                player1 = Winner,
                player2 = Loser,
                data = atp_clay_data)

# Summary of the model
summary(bt_model)



# Obtain player rankings
player_rankings <- predict(bt_model, type = "response")

# Show the player rankings
player_rankings



# Convert Winner and Loser to factors with the same levels as in the original data
new_winner <- factor("Darderi L.", levels = levels(atp_clay_data$Winner))
new_loser <- factor("Cerundolo F.", levels = levels(atp_clay_data$Loser))

# Make predictions
predict(bt_model, newdata = data.frame(Winner = new_winner, Loser = new_loser), type = "response")

