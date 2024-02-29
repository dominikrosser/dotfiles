#!/bin/bash

notify-send "Checking for new MMP2 Serie..."

# Due date for MMP2 Serie 01
base_due_date="2024-03-07"

# Calculate today's date
today=$(date +%Y-%m-%d)

# Calculate the difference in days from the base due date to today
days_diff=$((($(date -d "$today" +%s) - $(date -d "$base_due_date" +%s)) / 86400))

# Calculate series number based on the difference in days
# Since each series lasts for 7 days, dividing the days difference by 7 gives the series number offset from the first series
# Adding 1 to adjust for the current series number since the calculation starts from 0
serie_num=$((days_diff / 7 + 1))

# Format the series number to two digits
serie_num_formatted=$(printf "%02d" $serie_num)

# Calculate this series' due date by adding the days difference to the base due date
# This calculation assumes each series is exactly one week after the previous one's due date
due_date=$(date -d "$base_due_date +$((serie_num - 1)) week" +%Y-%m-%d)

# Check if a todo with the current series already exists
if nb eth-s4:q "#MMP2Serie$serie_num_formatted" | grep -q "MMP2 Serie $serie_num_formatted"; then
    echo "MMP2 Serie $serie_num_formatted already exists. No action taken."
else
    # Add the new todo item
    nb eth-s4:todo add "MMP2 Serie $serie_num_formatted" --due "$due_date" --tags MMP2,Serie,MMP2Serie$serie_num_formatted
    # Notify the user
    notify-send "New MMP2 Serie Added" "MMP2 Serie $serie_num_formatted due on $due_date"
    echo "Added: MMP2 Serie $serie_num_formatted due on $due_date"
fi
