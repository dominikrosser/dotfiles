#!/bin/bash

# base start date for Serie 01
base_date="2024-02-20"

# base due date for Serie 01
base_due_date="2024-02-26"

# Calculate the number of weeks since base date
today=$(date +%Y-%m-%d)
week_num=$((($(date -d "$today" +%s) - $(date -d "$base_date" +%s)) / 86400 / 7))

# Format the series number (ensure it is two digits)
serie_num=$(printf "%02d" $((week_num + 1)))

# Calculate this week's due date
due_date=$(date -d "$base_due_date +$week_num week" +%Y-%m-%d)

# Check if a todo with the current series already exists
if nb eth-s4:q "#TdWSerie$serie_num" | grep -q "TdW Serie $serie_num"; then
    echo "TdW Serie $serie_num already exists. No action taken."
else
    # Add the new todo item
    nb eth-s4:todo add "TdW Serie $serie_num" --due "$due_date" --tags TdW,Serie,TdWSerie$serie_num
    # Notify the user
    notify-send "New TdW Serie Added" "TdW Serie $serie_num due on $due_date"
    echo "Added: TdW Serie $serie_num due on $due_date"
fi
