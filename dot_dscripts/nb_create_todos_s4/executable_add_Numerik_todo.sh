#!/bin/bash

notify-send "Checking for new Numerik Serie..."

# Base start date for Numerik Serie 01
base_date="2024-02-19" # Opened on 19 Feb 2024

# Base due date for Numerik Serie 01
base_due_date="2024-02-25" # Closed on 25 Feb 2024

# Calculate the number of weeks since the base date
today=$(date +%Y-%m-%d)
week_num=$((($(date -d "$today" +%s) - $(date -d "$base_date" +%s)) / 86400 / 7))

# Format the series number (ensure it is two digits)
serie_num=$(printf "%02d" $((week_num + 1)))

# Calculate this week's due date
due_date=$(date -d "$base_due_date +$week_num week" +%Y-%m-%d)

# Check if a todo with the current series already exists
if nb eth-s4:q "#NumerikSerie$serie_num" | grep -q "Numerik Serie $serie_num"; then
    echo "Numerik Serie $serie_num already exists. No action taken."
else
    # Add the new todo item
    nb eth-s4:todo add "Numerik Serie $serie_num" --due "$due_date" --tags Numerik,Serie,NumerikSerie$serie_num
    # Notify the user
    notify-send "New Numerik Serie Added" "Numerik Serie $serie_num due on $due_date"
    echo "Added: Numerik Serie $serie_num due on $due_date"
fi

