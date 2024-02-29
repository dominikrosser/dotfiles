#!/bin/bash

notify-send "Checking for new ED Serie..."

# Base start date for ED Serie 01
base_date="2024-02-21" # Opened: Wednesday, 21 February 2024, 9:45 AM

# Base due date for ED Serie 01
base_due_date="2024-02-26" # Due: Monday, 26 February 2024, 12:00 PM

# Calculate the number of weeks since base date
today=$(date +%Y-%m-%d)
week_num=$((($(date -d "$today" +%s) - $(date -d "$base_date" +%s)) / 86400 / 7))

# Format the series number (ensure it is two digits)
serie_num=$(printf "%02d" $((week_num + 1)))

# Calculate this week's due date
due_date=$(date -d "$base_due_date +$week_num week" +%Y-%m-%d)

# Check if a todo with the current series already exists
if nb eth-s4:q "#EDSerie$serie_num" | grep -q "ED Serie $serie_num"; then
    echo "ED Serie $serie_num already exists. No action taken."
else
    # Add the new todo item
    nb eth-s4:todo add "ED Serie $serie_num" --due "$due_date" --tags ED,Serie,EDSerie$serie_num
    # Notify the user
    notify-send "New ED Serie Added" "ED Serie $serie_num due on $due_date"
    echo "Added: ED Serie $serie_num due on $due_date"
fi
