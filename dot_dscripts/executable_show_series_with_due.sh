
#!/bin/zsh

# Directly using the full command instead of the alias 'serien'
todo_output=$(nb eth-s4:todos open --tags "#Serie")

# Use awk to extract IDs
todo_ids=($(echo "$todo_output" | awk -F '[][]' '{print $1}' | grep -E '^[0-9]+$'))

# Check if IDs were found
if [ ${#todo_ids[@]} -eq 0 ]; then
    echo "No IDs extracted. Check the output format and extraction method."
    exit 1
else
    echo "Extracted IDs: ${todo_ids[@]}"
fi

# Proceed with using extracted IDs
for id in "${todo_ids[@]}"; do
    echo "Fetching details for Todo ID $id:"
    # Use nb to view each todo, adjusting the command as needed
    nb view "$id" | grep -A 2 '## Due' | tail -n 2
    echo
done

