
#!/bin/bash

notify-send "Checking for new MMP2 Serie..."

# Corrected base start date for Serie 01
# Assuming the start is one week before the due date as with the TdW example
# This will depend on how you define the "start" relative to the due date
base_date="2024-02-28" # This should be adjusted if the series starts on a different date

# Corrected base due date for Serie 01
base_due_date="2024-03-07"

# Calculate today's date
today=$(date +%Y-%m-%d)

# Calculate the number of weeks since the base start date
week_num=$((($(date -d "$today" +%s) - $(date -d "$base_date" +%s)) / 86400 / 7))

# Calculate series number (ensure it is two digits)
serie_num=$(printf "%02d" $((week_num + 1)))

# Calculate this series' due date by adding the number of weeks to the base due date
due_date=$(date -d "$base_due_date +$week_num week" +%Y-%m-%d)

# Check if a todo with the current series already exists
if nb eth-s4:q "#MMP2Serie$serie_num" | grep -q "MMP2 Serie $serie_num"; then
    echo "MMP2 Serie $serie_num already exists. No action taken."
else
    # Add the new todo item
    nb eth-s4:todo add "MMP2 Serie $serie_num" --due "$due_date" --tags MMP2,Serie,MMP2Serie$serie_num
    # Notify the user
    notify-send "New MMP2 Serie Added" "MMP2 Serie $serie_num due on $due_date"
    echo "Added: MMP2 Serie $serie_num due on $due_date"
fi

