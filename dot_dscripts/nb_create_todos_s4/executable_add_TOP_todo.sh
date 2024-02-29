#!/bin/bash

notify-send "Checking for new Topologie Serie..."

# Base start date for TOP Serie 01
base_date="2024-02-21" # Uploaded on 21 Feb 2024

# Base due date for TOP Serie 01
base_due_date="2024-02-28" # Due by 28 Feb 2024

# Calculate the number of weeks since the base date
today=$(date +%Y-%m-%d)
week_num=$((($(date -d "$today" +%s) - $(date -d "$base_date" +%s)) / 86400 / 7))

# Format the series number (ensure it is two digits)
serie_num=$(printf "%02d" $((week_num + 1)))

# Calculate this week's due date
due_date=$(date -d "$base_due_date +$week_num week" +%Y-%m-%d)

# Check if a todo with the current series already exists
if nb eth-s4:q "#TOPSerie$serie_num" | grep -q "TOP Serie $serie_num"; then
    echo "TOP Serie $serie_num already exists. No action taken."
else
    # Add the new todo item
    nb eth-s4:todo add "TOP Serie $serie_num" --due "$due_date" --tags TOP,Serie,TOPSerie$serie_num
    # Notify the user
    notify-send "New TOP Serie Added" "TOP Serie $serie_num due on $due_date"
    echo "Added: TOP Serie $serie_num due on $due_date"
fi

