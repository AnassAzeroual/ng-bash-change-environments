#!/bin/bash

echo "Updating config.ts..."

# Read the keys in the config.ts file and create a sed command to set all values to null
SED_COMMAND=""
while read -r line; do
  VAR_NAME=$(echo "$line" | grep -Eo '^[^:]+')
  SED_COMMAND+="s/\b$VAR_NAME:\s*\"[^\"]*\"/$VAR_NAME: null/g;"
done < <(grep -Eo '^[^:]+:' src/assets/config.ts)

# Execute the sed command to update the config.ts file
sed -i "$SED_COMMAND" src/assets/config.ts

echo "Config.ts updated."
